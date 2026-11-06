# EBikes Duniya security hardening – deployment notes

## Scope and safety
This branch introduces shared security helpers and a database migration script. It is not production-ready until the Web Forms application includes the helper source files in its compilation model, all credential flows are migrated consistently, and staging tests pass. No production database or deployment was changed.

## Confirmed current-main findings
- Customer, vendor and admin authentication compares submitted passwords with Users.PasswordHash directly.
- Registration and password-reset paths store submitted passwords directly.
- ClientMaster.master.cs trusts EBikesUser.UserID and Name from a client-editable cookie.
- Vendor rental/order status WebMethods do not consistently bind the requested record to authenticated VendorID.
- Multiple upload handlers trust original names/extensions or do not validate content signatures.
- Client/Bikes.aspx.cs and Client/Rental.aspx.cs build SQL IN clauses from client-provided brand strings.
- tables.sql contains example user records with plaintext-looking passwords. Treat sample credentials as exposed and rotate any reused credentials.

## New files
- Security/PasswordSecurity.cs: PBKDF2-HMAC-SHA256 hashing and fixed-time verification, compatible with .NET Framework 4.8.
- Security/UploadSecurity.cs: image extension, size and magic-byte validation with GUID filenames.
- Database/security-hardening.sql: idempotent RememberMeTokens table/index creation.

## Required follow-up before production
1. Add Security/*.cs to the Web Application project file (or confirm App_Code compilation if this is a Web Site project). The repository currently lacks .csproj, .sln, Web.config and Default.aspx, so project type and compilation inclusion cannot be verified.
2. Migrate Customer/Vendor/Admin registration, login, reset and change-password handlers together. Use PBKDF2 for new passwords; on successful legacy plaintext login, immediately replace the stored value with a PBKDF2 hash. Never store or log submitted credentials.
3. Implement remember-me with a random 256-bit token; store only SHA-256(token) in RememberMeTokens; cookie contains only the opaque token with HttpOnly, Secure on HTTPS, SameSite=Lax, Path=/ and expiry. Rotate on use and revoke on logout/password change. Never serialize UserID or display name in the cookie.
4. Add role + ownership predicates to every Vendor/customer mutation endpoint. For orders, update a record only when an OrderItems row for the authenticated vendor belongs to that order; do not modify a multi-vendor order's global status without clear business rules.
5. Validate status transitions using an allow-list and include current status in UPDATE predicates.
6. Use UploadSecurity.SaveImage for every image upload; ensure uploaded content is non-executable using IIS request filtering/handler mapping or storage outside web root where hosting permits.
7. Parameterize dynamic filters; parse brand IDs as integers and create one SQL parameter per value. Whitelist sort column/direction.
8. Encode database strings before writing HTML. Prefer JSON data + safe DOM textContent; avoid inline event handlers generated from database values.
9. Back up and test on staging before any production DB or hosting changes.
