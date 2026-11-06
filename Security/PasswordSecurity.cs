using System;
using System.Security.Cryptography;

namespace EBIke.Security
{
    /// <summary>
    /// PBKDF2-HMAC-SHA256 password hashing compatible with .NET Framework 4.8.
    /// Format: PBKDF2$iterations$base64(salt)$base64(hash)
    /// </summary>
    public static class PasswordSecurity
    {
        private const int SaltSize = 16;
        private const int HashSize = 32;
        private const int Iterations = 210000;
        private const string Prefix = "PBKDF2";

        public static string HashPassword(string password)
        {
            if (String.IsNullOrEmpty(password))
                throw new ArgumentException("Password is required.", "password");

            byte[] salt = new byte[SaltSize];
            using (var rng = RandomNumberGenerator.Create())
                rng.GetBytes(salt);

            using (var derive = new Rfc2898DeriveBytes(password, salt, Iterations, HashAlgorithmName.SHA256))
            {
                byte[] hash = derive.GetBytes(HashSize);
                return Prefix + "$" + Iterations + "$" +
                    Convert.ToBase64String(salt) + "$" +
                    Convert.ToBase64String(hash);
            }
        }

        public static bool VerifyPassword(string password, string storedValue)
        {
            if (String.IsNullOrEmpty(password) || String.IsNullOrEmpty(storedValue))
                return false;

            string[] parts = storedValue.Split('$');
            if (parts.Length != 4 || parts[0] != Prefix)
                return false;

            int iterations;
            if (!Int32.TryParse(parts[1], out iterations) || iterations < 100000 || iterations > 1000000)
                return false;

            byte[] salt;
            byte[] expected;
            try
            {
                salt = Convert.FromBase64String(parts[2]);
                expected = Convert.FromBase64String(parts[3]);
            }
            catch (FormatException) { return false; }

            if (salt.Length < 16 || expected.Length != HashSize)
                return false;

            byte[] actual;
            using (var derive = new Rfc2898DeriveBytes(password, salt, iterations, HashAlgorithmName.SHA256))
                actual = derive.GetBytes(expected.Length);

            return FixedTimeEquals(actual, expected);
        }

        private static bool FixedTimeEquals(byte[] left, byte[] right)
        {
            if (left == null || right == null || left.Length != right.Length)
                return false;

            int diff = 0;
            for (int i = 0; i < left.Length; i++)
                diff |= left[i] ^ right[i];

            return diff == 0;
        }

        public static bool IsHashed(string value)
        {
            return !String.IsNullOrEmpty(value) && value.StartsWith(Prefix + "$", StringComparison.Ordinal);
        }
    }
}
