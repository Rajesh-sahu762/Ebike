using System;
using System.IO;
using System.Web.UI.WebControls;

/// <summary>
/// Secure file upload validator and handler.
/// Validates file extensions, MIME types, magic byte signatures, and file size,
/// while generating unpredictable random filenames to prevent path traversal and execution.
/// </summary>
public static class FileUploadHelper
{
    public const int DefaultMaxSizeBytes = 5 * 1024 * 1024; // 5 MB

    public static readonly string[] AllowedExtensions = { ".jpg", ".jpeg", ".png", ".webp" };
    public static readonly string[] AllowedMimeTypes = { "image/jpeg", "image/pjpeg", "image/png", "image/x-png", "image/webp" };

    /// <summary>
    /// Checks if a file name has an allowed image extension.
    /// </summary>
    public static bool IsAllowedExtension(string fileName)
    {
        if (string.IsNullOrEmpty(fileName)) return false;
        string ext = Path.GetExtension(fileName).ToLowerInvariant();
        foreach (string allowed in AllowedExtensions)
        {
            if (ext == allowed) return true;
        }
        return false;
    }

    /// <summary>
    /// Checks if a MIME content type is allowed.
    /// </summary>
    public static bool IsAllowedMimeType(string mimeType)
    {
        if (string.IsNullOrEmpty(mimeType)) return false;
        string mt = mimeType.ToLowerInvariant();
        foreach (string allowed in AllowedMimeTypes)
        {
            if (mt == allowed) return true;
        }
        return false;
    }

    /// <summary>
    /// Validates an uploaded image and saves it with a randomized filename.
    /// Returns true if successful and outputs the generated filename.
    /// </summary>
    public static bool TrySaveImage(FileUpload fileUpload, string targetPhysicalDirectory, out string savedFileName, out string errorMessage, int maxSizeBytes = DefaultMaxSizeBytes)
    {
        savedFileName = string.Empty;
        errorMessage = string.Empty;

        if (fileUpload == null || !fileUpload.HasFile || fileUpload.PostedFile == null)
        {
            errorMessage = "No file selected.";
            return false;
        }

        // 1. File size check
        if (fileUpload.PostedFile.ContentLength <= 0)
        {
            errorMessage = "Uploaded file is empty.";
            return false;
        }

        if (fileUpload.PostedFile.ContentLength > maxSizeBytes)
        {
            errorMessage = string.Format("File size exceeds maximum allowed limit of {0} MB.", maxSizeBytes / (1024 * 1024));
            return false;
        }

        // 2. Extension validation
        string originalFileName = Path.GetFileName(fileUpload.FileName);
        string ext = Path.GetExtension(originalFileName).ToLowerInvariant();

        if (!IsAllowedExtension(originalFileName))
        {
            errorMessage = "Only JPG, PNG, and WebP images are allowed.";
            return false;
        }

        // 3. MIME type validation
        string contentType = fileUpload.PostedFile.ContentType.ToLowerInvariant();
        if (!IsAllowedMimeType(contentType))
        {
            errorMessage = "Invalid image content type.";
            return false;
        }

        // 4. File signature (magic bytes) validation
        using (Stream stream = fileUpload.PostedFile.InputStream)
        {
            if (!IsValidImageSignature(stream, ext))
            {
                errorMessage = "File contents do not match a valid image signature.";
                return false;
            }
        }

        // 5. Generate secure random filename
        string randomName = Guid.NewGuid().ToString("N") + ext;

        if (!Directory.Exists(targetPhysicalDirectory))
        {
            Directory.CreateDirectory(targetPhysicalDirectory);
        }

        string fullPath = Path.Combine(targetPhysicalDirectory, randomName);
        fileUpload.SaveAs(fullPath);

        savedFileName = randomName;
        return true;
    }

    /// <summary>
    /// Inspects the file stream for valid magic bytes matching the file extension.
    /// </summary>
    public static bool IsValidImageSignature(Stream stream, string ext)
    {
        if (stream == null || !stream.CanRead)
            return false;

        long originalPos = stream.Position;
        try
        {
            stream.Position = 0;
            byte[] header = new byte[12];
            int read = stream.Read(header, 0, 12);
            if (read < 4)
                return false;

            if (ext == ".jpg" || ext == ".jpeg")
            {
                // JPEG magic bytes: FF D8 FF
                return header[0] == 0xFF && header[1] == 0xD8 && header[2] == 0xFF;
            }

            if (ext == ".png")
            {
                // PNG magic bytes: 89 50 4E 47 0D 0A 1A 0A
                if (read < 8) return false;
                return header[0] == 0x89 && header[1] == 0x50 && header[2] == 0x4E && header[3] == 0x47 &&
                       header[4] == 0x0D && header[5] == 0x0A && header[6] == 0x1A && header[7] == 0x0A;
            }

            if (ext == ".webp")
            {
                // WebP: RIFF....WEBP
                if (read < 12) return false;
                return header[0] == 0x52 && header[1] == 0x49 && header[2] == 0x46 && header[3] == 0x46 &&
                       header[8] == 0x57 && header[9] == 0x45 && header[10] == 0x42 && header[11] == 0x50;
            }

            return false;
        }
        finally
        {
            stream.Position = originalPos;
        }
    }
}

