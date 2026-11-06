using System;
using System.Security.Cryptography;

namespace EBIke.Security
{
    public static class OtpSecurity
    {
        // Uniform cryptographically secure six-digit OTP.
        public static string GenerateSixDigitOtp()
        {
            const uint range = 900000;
            const uint limit = UInt32.MaxValue - (UInt32.MaxValue % range);
            byte[] bytes = new byte[4];
            uint value;
            using (var rng = RandomNumberGenerator.Create())
            {
                do
                {
                    rng.GetBytes(bytes);
                    value = BitConverter.ToUInt32(bytes, 0);
                } while (value >= limit);
            }
            return (100000 + (value % range)).ToString("D6");
        }
    }
}
