# EBikes Duniya – security hardening branch notes

## Scope and safety
This branch contains a first critical-security patch set for the existing ASP.NET Web Forms application. It does not change the Client/Admin/Vendor folder architecture and does not implement the separate URL/routing work yet.

- Target: .NET Framework 4.8 / ASP.NET Web Forms / SQL Server.
- Working branch: `security/critical-hardening`.
- `main` was not modified.
- No production database, MonsterASP hosting settings, or live deployment was changed.
- No .NET Framework build, IIS run, or database integration test could be executed in this environment. Treat this as a reviewable draft, not a verified production release.

## Critical fixes implemented in this branch

### Passwords and authentication
- Added `App_Code/PasswordSecurity.cs` using PBKDF2-HMAC-SHA256, per-password random salt, and fixed-time hash comparison.
- Customer and Vendor registration now store PBKDF2 hashes.
- Customer, Vendor and Admin login verify PBKDF2 hashes and upgrade legacy plaintext values to PBKDF2 after a successful login.
- Customer and Vendor password reset and customer/vendor password-change flows now write PBKDF2 hashes.
- Login handlers use account lockout counters; Admin login has the same basic 5-attempt / 5-minute lockout.
- Customer profile no longer updates the login email through an unverified profile form. A future email-change flow must verify the new address first.

**Important migration limitation:** legacy plaintext password rows are still accepted during the transition so existing accounts can sign in and be upgraded. That means this patch alone does not remove every legacy plaintext value from the production database. Before declaring password-at-rest remediation complete, back up the database and either force password resets or perform a carefully tested one-time migration that hashes every remaining legacy value. Do not hash values already carrying the `PBKDF2$` prefix.

### Remember-me
- Added `App_Code/RememberMeSecurity.cs`.
- The browser cookie contains only a random opaque token; the database stores its SHA-256 hash.
- Token restore rotates the token; logout and password-change/reset paths revoke tokens.
- This requires the `RememberMeTokens` table from the SQL migration below.
- Cookie `Secure` depends on HTTPS being active. Production HTTPS and session-cookie settings still need configuration verification.

### OTP
- Added `App_Code/OtpSecurity.cs` using a cryptographically secure random-number generator.
- Updated customer/vendor email verification and password-reset flows to use secure OTP generation, expiry, one-time invalidation and per-account attempt limits.
- Resend cooldown is 60 seconds.
- The migration adds `OTPFailedAttempts` and `OTPResendAt` to `dbo.Users`.

**Remaining OTP limitation:** this is account-level throttling, not an IP/global rate limiter. OTP values are still stored in the existing database OTP column; consider storing a keyed hash instead in a later hardening pass.

### Vendor ownership and status transitions
- Rental reads and updates are scoped to the authenticated `VendorID`.
- Rental updates validate the allowed next status and the current status in the UPDATE predicate.
- Order item detail reads are restricted to the authenticated vendor's own OrderItems.
- Vendor order updates are scoped to orders that contain only that vendor's items. Because the current schema has one global `Orders.OrderStatus`, updates to multi-vendor orders are rejected rather than allowing one vendor to change another vendor's fulfillment state.

A proper per-vendor fulfillment status requires a later schema/business-flow design; this patch intentionally does not invent one.

### Uploads
- Added `App_Code/UploadSecurity.cs`.
- The existing customer used-bike, Vendor bike/parts/profile, Admin logo and Admin brand-logo upload paths now use an extension allowlist, a 5 MB limit, basic image signature checks and generated filenames.
- Accepted formats: JPG, JPEG, PNG and WEBP.

**Hosting requirement:** ensure `/Uploads` is non-executable at IIS/hosting level (deny ASPX/script execution and remove handler mappings there), or store uploads outside the web root where hosting permits. Header validation does not replace server-side non-execution controls or full image decoding/re-encoding.

### SQL injection, XSS and WebMethods
- Bike/Rental brand filters parse numeric IDs and use one SQL parameter per ID; range and paging inputs are validated/bounded.
- Admin GridView sorting uses an explicit column allowlist and ASC/DESC direction validation.
- Session-dependent Client WebMethods now enable session.
- Admin notification WebMethods now require an active Admin session and validate the role in the database.
- Search suggestions use DOM APIs and `textContent` rather than inserting database strings into `innerHTML`.
- Bike/Rental list cards, detail-page descriptions/reviews/specification strings, similar-bike labels and image paths received contextual encoding/validation.
- Vendor rental cards and Vendor order details no longer render untrusted database item names as raw HTML.
- Admin lead-message output is HTML-encoded.

This is a targeted critical-path remediation, not a claim that every literal, repeater, template and JavaScript sink across all pages has had a complete XSS review.

### Seed data hygiene
- Replaced the four user seed records in `tables.sql` with disabled placeholder accounts, placeholder email/phone values, reset-required password placeholders and cleared OTP data. User IDs are retained to avoid breaking seed relationships.
- Replaced the default Admin seed in `SQLQuery1.sql` with a disabled placeholder account.
- No SMTP secret was populated in the inspected SiteSettings seed row.

**Git history warning:** changing the current files does not erase old values from earlier public commits. Treat any real credentials or personal data in the old history as exposed. Rotate any reused passwords and remove sensitive values from Git history using a separately planned history rewrite; coordinate before force-pushing rewritten history.

## Database migration

File: `Database/security-hardening.sql`

Run only against a backup/staging database first. It creates `dbo.RememberMeTokens` and adds `OTPFailedAttempts` and `OTPResendAt` when absent. It has **not** been run against production or staging by this patch.

The application deployment must not happen before the schema migration has been reviewed and applied to the intended database.

## Project/configuration items not present in the repository snapshot
The repository currently does not include `Web.config`, `.csproj`, `.sln` or `Default.aspx`. The updated pages use Web Forms `CodeFile` directives and shared helpers are under `App_Code`, but the actual project configuration/build model still needs verification.

Before deployment, review sanitized `<system.web>` and `<system.webServer>` sections only. Redact connection strings, SMTP credentials, API keys and all other secrets. Verify:
- HTTPS redirect and certificate state;
- `httpOnlyCookies`, secure session/auth cookies and SameSite policy;
- custom errors and compilation/debug settings;
- request size limits and request filtering;
- non-executable upload directory configuration;
- security headers and handler mappings.

## Required verification before production
1. Open the branch in the original Visual Studio Web Forms solution and confirm App_Code compilation and all referenced controls/events.
2. Build against .NET Framework 4.8; resolve any compile errors before testing.
3. Apply the database migration to a restored staging database.
4. Test every Client/Vendor/Admin login, registration, verification, reset, change-password, remember-me and logout flow.
5. Test Vendor A attempting to read/update Vendor B rentals and orders; test mixed-vendor orders are rejected.
6. Test upload extension spoofing, invalid signatures, oversized files and IIS script-execution denial.
7. Test bike/rental filtering, all sorting columns, detail pages, search suggestions, postbacks and AJAX/session calls.
8. Run SQL injection, stored/reflected XSS, CSRF and authorization regression tests.
9. Back up the current production database and deployed files before a controlled release. Do not deploy directly from this draft branch.

## Known residual risks / next pass
- Legacy plaintext password rows remain until upgraded or force-reset; transitional legacy verification remains active.
- IP/global rate limiting and CSRF defenses for state-changing AJAX/WebMethods still need a dedicated pass.
- HTTPS, cookie flags, security headers and upload non-execution must be verified in hosting configuration.
- More pages may contain unreviewed HTML/JavaScript sinks or authorization gaps; a full source-wide pass remains required.
- Multi-vendor order fulfillment needs per-vendor status modeling before allowing each vendor to progress their own items.
- The separate centralized URL/routing fix has intentionally not been started.
