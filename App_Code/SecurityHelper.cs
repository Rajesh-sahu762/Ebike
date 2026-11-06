using System;
using System.IO;
using System.Security.Cryptography;
using System.Text;

/// <summary>
/// Core security helper providing PBKDF2 password hashing, legacy password verification,
/// cryptographically secure random token generation, and input sanitization.
/// </summary>
public static class SecurityHelper
{
    private const int SaltByteSize = 16;
    private const int HashByteSize = 32;
    private const int Pbkdf2Iterations = 100000;
    private const string HashPrefix = "PBKDF2";

    /// <summary>
    /// Hashes a plaintext password using PBKDF2 with a cryptographically secure random salt and 100,000 iterations.
    /// Format: PBKDF2$100000$<salt_base64>$<hash_base64>
    /// </summary>
    public static string HashPassword(string password)
    {
        if (password == null)
            throw new ArgumentNullException("password");

        byte[] salt = new byte[SaltByteSize];
        using (RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider())
        {
            rng.GetBytes(salt);
        }

        byte[] hash = ComputePbkdf2Hash(password, salt, Pbkdf2Iterations, HashByteSize);

        return string.Format("{0}${1}${2}${3}",
            HashPrefix,
            Pbkdf2Iterations,
            Convert.ToBase64String(salt),
            Convert.ToBase64String(hash));
    }

    /// <summary>
    /// Verifies a password against a stored hash or legacy plaintext password.
    /// Sets needsUpgrade to true if the stored value was valid plaintext and should be upgraded to PBKDF2.
    /// </summary>
    public static bool VerifyPassword(string inputPassword, string storedHash, out bool needsUpgrade)
    {
        needsUpgrade = false;

        if (string.IsNullOrEmpty(inputPassword) || string.IsNullOrEmpty(storedHash))
            return false;

        // Check if the stored password uses PBKDF2 format
        if (storedHash.StartsWith(HashPrefix + "$"))
        {
            string[] parts = storedHash.Split('$');
            if (parts.Length != 4)
                return false;

            int iterations;
            if (!int.TryParse(parts[1], out iterations) || iterations <= 0)
                return false;

            byte[] salt;
            byte[] expectedHash;
            try
            {
                salt = Convert.FromBase64String(parts[2]);
                expectedHash = Convert.FromBase64String(parts[3]);
            }
            catch (FormatException)
            {
                return false;
            }

            byte[] actualHash = ComputePbkdf2Hash(inputPassword, salt, iterations, expectedHash.Length);
            return FixedTimeEquals(actualHash, expectedHash);
        }

        // Safe legacy migration: compare plaintext. If match, mark for upgrade.
        if (storedHash == inputPassword)
        {
            needsUpgrade = true;
            return true;
        }

        return false;
    }

    /// <summary>
    /// Derives a key using PBKDF2 (Rfc2898DeriveBytes).
    /// </summary>
    private static byte[] ComputePbkdf2Hash(string password, byte[] salt, int iterations, int outputBytes)
    {
        using (Rfc2898DeriveBytes pbkdf2 = new Rfc2898DeriveBytes(password, salt, iterations))
        {
            return pbkdf2.GetBytes(outputBytes);
        }
    }

    /// <summary>
    /// Constant-time byte array comparison to protect against timing attacks.
    /// </summary>
    public static bool FixedTimeEquals(byte[] a, byte[] b)
    {
        if (a == null || b == null || a.Length != b.Length)
            return false;

        int diff = 0;
        for (int i = 0; i < a.Length; i++)
        {
            diff |= a[i] ^ b[i];
        }
        return diff == 0;
    }

    /// <summary>
    /// Generates a cryptographically secure random token (URL-safe string).
    /// </summary>
    public static string GenerateSecureToken(int byteLength = 32)
    {
        byte[] bytes = new byte[byteLength];
        using (RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider())
        {
            rng.GetBytes(bytes);
        }
        // Base64 URL-safe string
        return Convert.ToBase64String(bytes).Replace("+", "-").Replace("/", "_").TrimEnd('=');
    }

    /// <summary>
    /// Computes the SHA-256 hash of a string, returned as a lowercase hex string.
    /// Used for storing tokens securely in the database.
    /// </summary>
    public static string HashSha256(string input)
    {
        if (string.IsNullOrEmpty(input))
            return string.Empty;

        using (SHA256 sha = SHA256.Create())
        {
            byte[] hash = sha.ComputeHash(Encoding.UTF8.GetBytes(input));
            StringBuilder sb = new StringBuilder(hash.Length * 2);
            for (int i = 0; i < hash.Length; i++)
            {
                sb.Append(hash[i].ToString("x2"));
            }
            return sb.ToString();
        }
    }

    /// <summary>
    /// Generates a cryptographically secure numeric OTP using RNGCryptoServiceProvider.
    /// </summary>
    public static string GenerateOtp(int length = 6)
    {
        if (length <= 0 || length > 9)
            length = 6;

        int min = (int)Math.Pow(10, length - 1);
        int max = (int)Math.Pow(10, length) - 1;
        int diff = max - min + 1;

        byte[] buffer = new byte[4];
        using (RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider())
        {
            rng.GetBytes(buffer);
        }

        uint rand = BitConverter.ToUInt32(buffer, 0);
        int otp = (int)(min + (rand % (uint)diff));
        return otp.ToString();
    }

    /// <summary>
    /// Whitelists a sort column expression against a set of allowed column names.
    /// </summary>
    public static string SanitizeSortColumn(string inputColumn, string[] allowedColumns, string defaultColumn)
    {
        if (string.IsNullOrEmpty(inputColumn) || allowedColumns == null)
            return defaultColumn;

        foreach (string col in allowedColumns)
        {
            if (string.Equals(col.Trim(), inputColumn.Trim(), StringComparison.OrdinalIgnoreCase))
                return col;
        }

        return defaultColumn;
    }

    /// <summary>
    /// Whitelists sort direction to either ASC or DESC.
    /// </summary>
    public static string SanitizeSortDirection(string inputDirection)
    {
        if (string.Equals(inputDirection, "DESC", StringComparison.OrdinalIgnoreCase))
            return "DESC";
        return "ASC";
    }
}

