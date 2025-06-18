# Project: Notepad Application (Spring Boot + MySQL + JSP)

---

## ✅ What Went Well

- **Modular Design**: The application is built with clear separation of controller, service, entity, and repository layers.
- **User Session Handling**: Authentication and session management were successfully implemented.
- **Basic CRUD Operations**: Create, Read, Update, Delete endpoints for notes are functional and secured.
- **Filename-based Operations**: Additional endpoints added for CRUD operations by filename.
- **File Upload Feature**: `.txt` file uploads are supported, parsed, validated, and stored as notes.
- **Swagger Integration**: API documentation enabled, with multipart/form-data support adjustments.
- **Basic Validation**: Filenames are validated to ensure clean input (e.g., extensions, no illegal characters).

---

## ❌ What Went Wrong / Impediments

- Swagger UI didn't initially support file uploads correctly until `@RequestPart` and `content-type` adjustments were made.
- Improper `.txt` extension appending was fixed by validating and modifying the filename.
- Swagger was initially asking for body input instead of file upload UI — clarified and resolved.

---

## 🧱 Impediments We Overcame

- **Swagger multipart/form-data**: Solved by shifting from `@RequestParam` to `@RequestPart` and adjusting method signature.
- **File Validation**: Introduced filename rules to prevent injection or upload issues.
- **Text Encoding**: Ensured UTF-8 reading of file content without corruption.

---

## 🌱 Future Enhancements / Upgrade Ideas

- **Versioning System**  
  Track previous versions of a note, not just created/updated timestamps.  
  Use a `note_versions` table to keep older content snapshots.

- **Trash / Soft Delete**  
  Move deleted notes to a `note_trashed` table instead of permanent deletion.  
  Allow restore operation.

- **Tagging & Categories**  
  Add a `tags` column or a separate `note_tags` mapping table.  
  Improve search and categorization UX.

- **Full-text Search**  
  Enable search within note content (e.g., using MySQL `FULLTEXT` or basic `LIKE` search).

- **Note Metadata**  
  Store word count and character count in the DB.  
  Auto-generate these at creation/update time.

- **Authorization Enhancements**  
  Implement role-based access (Admin, User, Moderator).  
  Restrict sensitive endpoints accordingly.

- **Activity Logs / Audit Trail**  
  Track actions like create/update/delete per session or user.  
  Create an `activity_log` table with timestamps.

- **Import / Export Support**  
  Allow bulk upload or export of notes as ZIPs or CSVs.  
  Combine with versioning and trash to retain history.

- **Virtual Folders / Organization**  
  Group notes in user-defined folders or collections.  
  Useful for download/export as well.

- **Reminders / Timed Notes**  
  Notes can be scheduled with reminder time.  
  Optional notifications later during UI/dashboard phase.

---

## 📦 Project File Convention

- `application-local.properties` → Local configuration.
- `project-journal.md` → Developer documentation, retrospective notes, plans.
- `.md` is chosen for Markdown format, easier formatting, compatible with GitHub / GitLab.

---

## 🔍 Observations

- Markdown is preferred over `.txt` for structured, styled documentation.
- This documentation habit is beneficial for tracking thought process, reasoning, and planning.
- Should be maintained consistently with every feature or milestone.

---

## 📅 Timeline Summary (so far)

- ✅ User Auth via Session: Done
- ✅ CRUD by ID & Filename: Done
- ✅ File Upload: Done
- 🟡 Download Feature: On Hold
- 🟢 Journal & Docs: In Progress
- 🔜 Versioning, Trash, Tags: Pending

---

> _“This file is a living journal — an honest mirror of how this Notepad evolved, matured, and what's coming next.”_
