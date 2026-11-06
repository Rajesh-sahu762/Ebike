using System;
using System.IO;
using System.Web.UI.WebControls;

namespace EBIke.Security
{
    /// <summary>Strict image upload validation; uploaded files must also be non-executable at IIS level.</summary>
    public static class UploadSecurity
    {
        private const int MaxImageBytes = 5 * 1024 * 1024;

        public static string SaveImage(FileUpload upload, string physicalFolder)
        {
            if (upload == null || !upload.HasFile)
                return String.Empty;

            if (upload.PostedFile == null || upload.PostedFile.ContentLength <= 0 ||
                upload.PostedFile.ContentLength > MaxImageBytes)
                throw new InvalidOperationException("Image must be between 1 byte and 5 MB.");

            string ext = Path.GetExtension(upload.FileName).ToLowerInvariant();
            if (ext != ".jpg" && ext != ".jpeg" && ext != ".png" && ext != ".webp")
                throw new InvalidOperationException("Only JPG, PNG and WEBP images are allowed.");

            byte[] header = new byte[12];
            using (Stream stream = upload.PostedFile.InputStream)
            {
                int read = stream.Read(header, 0, header.Length);
                if (!IsAllowedSignature(header, read, ext))
                    throw new InvalidOperationException("The uploaded file is not a valid image.");

                stream.Position = 0;
                if (!Directory.Exists(physicalFolder))
                    Directory.CreateDirectory(physicalFolder);

                string fileName = Guid.NewGuid().ToString("N") + ext;
                upload.SaveAs(Path.Combine(physicalFolder, fileName));
                return fileName;
            }
        }

        private static bool IsAllowedSignature(byte[] h, int n, string ext)
        {
            if (ext == ".jpg" || ext == ".jpeg")
                return n >= 3 && h[0] == 0xFF && h[1] == 0xD8 && h[2] == 0xFF;
            if (ext == ".png")
                return n >= 8 && h[0] == 0x89 && h[1] == 0x50 && h[2] == 0x4E &&
                    h[3] == 0x47 && h[4] == 0x0D && h[5] == 0x0A && h[6] == 0x1A && h[7] == 0x0A;
            if (ext == ".webp")
                return n >= 12 && h[0] == 'R' && h[1] == 'I' && h[2] == 'F' && h[3] == 'F' &&
                    h[8] == 'W' && h[9] == 'E' && h[10] == 'B' && h[11] == 'P';
            return false;
        }
    }
}
