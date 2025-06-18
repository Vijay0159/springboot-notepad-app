# Project: Notepad Application (Spring Boot + MySQL + JSP)

A lightweight, full-stack Notepad web application designed to allow authenticated users to upload, store, view, and manage plain text notes. The project follows a modular MVC architecture using Spring Boot, JSP, and MySQL.

---

## ✅ What Went Well

- **Modular Design**: Clean separation between `controller`, `service`, `repository`, and `entity` layers allowed for easy development and maintenance.
- **Session-Based Authentication**: Users are authenticated via HTTP session attributes (`userId`, `username`), providing simple and secure stateful login handling.
- **CRUD Operations**: Users can create, read, update, and delete notes securely, both by ID and by filename.
- **Filename-based Access**: Operations using custom filenames are supported, improving UX for retrieval and management.
- **File Upload Capability**: `.txt` file upload with validations for extension, naming conventions, and content parsing is fully functional.
- **Swagger Integration**: Live API documentation using Swagger UI with proper `multipart/form-data` support was achieved by configuring `@RequestPart` annotations.
- **Filename Validation**: Rules implemented to avoid injection, path traversal (`/`, `\`), and multi-dot (`..`) issues.
- **JSP-based UI Bootstrapped**: A minimal JSP-based frontend is in place and ready for expansion (login, dashboard, upload forms, etc.).
- **Swagger Integration with Descriptive Annotations**  
  All endpoints are documented using `@Operation` (with `summary` and `description`) and `@ApiResponses`. File upload endpoints use `@RequestPart`, ensuring Swagger renders proper file selection UI.


---

## ❌ What Went Wrong / Impediments

- **Swagger Upload UI Glitch**  
  Swagger initially failed to show a file chooser due to incorrect use of `@RequestParam` for file uploads.
- **Swagger File Upload Glitch**: Swagger initially failed to render file upload UI due to incorrect `@RequestParam` usage.
- **File Naming Confusion**: Filenames were appended with `.txt` incorrectly or inconsistently; resolved with smart extension logic.
- **UI Development Delays**: Minimal UI was built due to prioritization of core backend functionality.

---

## 🧱 Impediments We Overcame

- **Multipart Support in Swagger**: Resolved by replacing `@RequestParam` with `@RequestPart`, setting `consumes = multipart/form-data`.
- **Filename & Content Validation**: Custom logic added to validate filenames and ensure content is safe and not empty.
- **UTF-8 Encoding**: Ensured all uploaded files are read and stored with UTF-8 encoding to avoid character corruption.
- **Swagger Annotations for Better UX**  
  Enhanced Swagger documentation with:
  - `@Operation(summary = "...", description = "...")`
  - `@ApiResponses(...)` to list all expected HTTP responses.
  - Improved readability and developer experience via Swagger UI.
---

## 🌱 Future Enhancements / Upgrade Ideas

### 🔧 Core Backend Upgrades
- **Versioning System**  
  Track previous versions of a note using a new `note_versions` table with version numbers and timestamps.

- **Trash / Soft Delete**  
  Instead of hard delete, notes will be moved to `note_trashed`, allowing restore or permanent purge.

- **Tagging & Categories**  
  Enable tagging system with a `note_tags` table or a `tags` column; allow filtering/search by tags.

- **Full-text Content Search**  
  Support `LIKE`-based or `FULLTEXT`-based MySQL search within the note content field.

- **Note Metadata**  
  Store `wordCount` and `characterCount` columns; computed and updated at note creation/edit time.

- **Audit Logs**  
  Track all major actions in `activity_log` with `userId`, `actionType`, `noteId`, `timestamp`.

### 🔐 Security and Access Control
- **Role-based Authorization**  
  Admin/Moderator/User roles using Spring Security. Restrict sensitive endpoints accordingly.

### 📥 Import / Export Support
- **Export Notes**  
  Allow user to download individual or grouped notes as `.txt`, `.zip`, or `.csv`.

- **Import Notes**  
  Bulk upload `.zip` of `.txt` files into their account.

### 📁 Folder Structure Support
- **Virtual Folders**  
  Allow users to group notes into logical folders; stored as metadata or folder-name prefix.

### ⏰ Reminders and Notifications
- **Timed Notes**  
  Notes with a future date-time alert to remind the user (to be surfaced via UI).

---

## 💻 UI Development Plan (JSP / HTML)

- **User Authentication Pages**: Login, Signup (Form-based JSPs).
- **Dashboard**: List notes with edit/delete/upload options.
- **Note Viewer/Editor**: Rich text display and edit capability for `.txt` files.
- **Search Bar**: Filter by title, tag, or folder.
- **Upload Form**: Multipart form with filename, file, and optional tags.
- **Trash View**: View and restore soft-deleted notes.
- **Export Panel**: Bulk-select notes to download as ZIP or CSV.
- **Reminder Panel**: Set and view reminders for notes.

> Frontend will be gradually built using JSP and styled using Bootstrap or Tailwind (if migrated to HTML/React later).

---

## 📦 Project File Convention

| File                         | Purpose                                                     |
|-----------------------------|-------------------------------------------------------------|
| `application-local.properties` | Local DB and server config used for dev profile             |
| `project-journal.md`        | This file: Documentation, changelog, retrospective & plans  |
| `NoteController.java`       | REST endpoints for note operations                          |
| `NoteService.java`          | Business logic and note validations                         |
| `NoteRepository.java`       | Spring JPA-based persistence logic                          |
| `Note.java`                 | JPA entity for notes                                        |
| `UserController.java`       | Handles login and dashboard redirection                     |
| `User.java`                 | User entity with ID, name, session-related attributes       |
| `notes.sql`                 | DB initialization / schema setup file                       |

---

## 🔍 Observations & Good Practices

- **Session-based auth** is simple but will be replaced with JWT/Spring Security for role management later.
- Markdown `.md` is ideal for internal project documentation and helps with long-term maintainability.
- Project is built in **Spring Boot 3+**, uses **Jakarta** imports, compatible with Java 17+.
- Logging and Exception Handling should be standardized using `@ControllerAdvice` and custom exception classes.
- We follow **layered architecture** consistently.
- All features are **testable via Postman or Swagger UI**.
- Code is clean, readable, and **uses RESTful principles** correctly.

---

## 📅 Timeline Summary

| Feature                             | Status       |
|-------------------------------------|--------------|
| Session-based User Auth             | ✅ Completed |
| CRUD by ID & Filename               | ✅ Completed |
| File Upload & Filename Validation   | ✅ Completed |
| Swagger Integration (with Multipart) | ✅ Completed |
| Basic JSP UI Bootstrapped           | 🟡 In Progress |
| Download / Export Notes             | 🔜 Planned |
| Versioning + Trash                  | 🔜 Planned |
| Tagging / Full-text Search          | 🔜 Planned |
| Audit Logging                       | 🔜 Planned |
| Role-based Authorization            | 🔜 Planned |
| UI Enhancements (Dashboard, Editor) | 🔜 Planned |

---

> _“This file is a living journal — an honest mirror of how this Notepad evolved, matured, and what's coming next.”_

