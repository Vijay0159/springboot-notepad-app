# Project: Notepad Application (Spring Boot + MySQL + JSP)

A lightweight, full-stack Notepad web application designed to allow authenticated users to upload, view, update, delete, and download plain text notes. The system follows an MVC pattern using Spring Boot, Hibernate (JPA), JSP, and MySQL.

---

## ✅ What Went Well

- **Modular Design**  
  Clear separation between controller, service, repository, and entity layers ensured clean code and easy maintenance.

- **Session-Based Authentication**  
  Logged-in users are tracked using session attributes (`userId`, `username`), offering simple and secure access control.

- **CRUD Operations by ID & Filename**  
  Users can manage notes via both internal ID and custom filenames.

- **Robust File Upload Handling**  
  `.txt` file uploads support both auto and manual naming, with validation for extensions, special characters, and double dots.

- **Filename Normalization**  
  Intelligent `.txt` extension handling added across all features to avoid duplicates and maintain consistency.

- **Modal-based Feedback System**  
  Success messages now appear in professional modals for create, update, delete, and upload flows — only after DB success.

- **Download Feature (Single & Bulk)**
    - Users can download individual notes by ID or filename (as `.txt`)
    - Users can bulk-download all notes as a `.zip` file directly from the All Notes view

- **JSP UI Enhancements**  
  All user operations (CRUD + fetch + upload) are supported via themed, modular JSPs.

- **Theme Toggle**  
  Light/dark theme support via JavaScript and CSS variables, synced across modals and UI.

- **All Notes: Sorting + Show More/Less**  
  Notes are sortable by ID or filename, and long content can be expanded/collapsed per entry.

- **Combined REST + JSP Setup**  
  REST APIs (for Swagger + testing) and JSP controllers work in harmony with shared business logic.

---

## ❌ What Went Wrong / Impediments

- **Filename Discrepancies**  
  Some flows appended `.txt`, while others didn’t — causing silent duplicates. Fixed with centralized logic.

- **Lack of Feedback on JSP Pages**  
  Many early pages showed no confirmation/error, confusing users about the result of their actions.

- **Modal Visibility Bugs**  
  Modals for deletion didn’t render due to controller returning the wrong view (`dashboard` instead of original form). Fixed.

- **JSTL Tag Errors**  
  Functions like `fn:length()` didn’t work until the correct `taglib` was imported explicitly.

- **Download Button Not Visible**  
  Fetch JSPs returned different views (like `noteDetails`) instead of staying on the same page, hiding buttons. This was refactored.

---

## 🧱 Impediments We Overcame

- **Consistent File Extension Handling**  
  Added a utility-like `normalizeTxtExtension()` in the controller to ensure that `.txt` is only appended if missing.

- **Unified Feedback Pattern**  
  Switched all forms to use model attributes like `modalSuccess`, `updatedFile`, `deletedFile`, etc., triggering consistent UI messages.

- **Theme-Compatible Modals**  
  Extended CSS to ensure modals respect dark/light themes and don't override layout or blur backgrounds.

- **Bulk Download via ZIP**  
  Instead of creating new endpoints, we enhanced the existing `/note/fetch/all` with a POST form to trigger `.zip` generation using `ZipOutputStream`.

- **Scoped CSS Fixes for Tables**  
  Adapted styles for both light and dark themes with smooth toggling and proper typography across notes list.

- **Duplicate Filename Check During Update**  
  Added a `noteService.isDuplicateFilenameForUserExceptId(...)` check to prevent collisions during filename updates.

---

## 🌱 Future Enhancements / Upgrade Ideas

### 🔧 Backend Enhancements
- **Note Versioning**  
  Add version history tracking for updates to allow rollback or review.

- **Trash Bin / Soft Delete**  
  Move deleted notes to a soft-deleted state for restore or permanent deletion.

- **Tagging and Folders**  
  Virtual folder or tagging support for organizing notes.

- **Note Analytics**  
  Store word/character counts and creation/update timestamps for dashboard insights.

- **Audit Logs**  
  Record user actions like login, upload, delete, and download with timestamps.

### 🔐 Security & Access
- **Role-Based Access**  
  Implement `USER`, `MODERATOR`, and `ADMIN` roles via Spring Security.

### 📥 Import / Export
- **Import ZIP of Notes**  
  Bulk import notes from a user’s `.zip` of `.txt` files.

- **Metadata Export**  
  Allow notes to be exported as CSV or with tags/metadata.

### 🧠 AI Integration (Post-MVP)
- **AI Assistant for Note Creation**  
  Add a GPT-powered helper to assist in note writing from a prompt (e.g., “Write an essay on India’s diversity”) directly in `createNote.jsp` and update pages.  
  *📌 To be implemented only after all current roadmap items are complete.*

### ⏰ Time-bound Notes & Reminders
- **Reminders UI + Notification Hooks**

---

## 💻 UI Development Tracker

| Feature                         | Status       |
|----------------------------------|--------------|
| Login & Session Auth             | ✅ Completed |
| Dashboard                        | ✅ Completed |
| Create / Update / Delete Views  | ✅ Completed |
| Upload Form                      | ✅ Completed |
| Fetch by ID / Filename           | ✅ Completed |
| Download Single Note             | ✅ Completed |
| Download All as ZIP              | ✅ Completed |
| Sort + Expand in All Notes View  | ✅ Completed |
| Modal-based Success Messages     | ✅ Completed |
| Dynamic Theme Support            | ✅ Completed |
| Tag, Folder, Search UI           | 🔜 Planned   |
| Trash / Restore Panel            | 🔜 Planned   |
| AI Note Assistant                | 🔜 Planned   |

---

## 📦 File Structure & Conventions

| File/Directory                      | Purpose                                                |
|------------------------------------|--------------------------------------------------------|
| `NoteViewController.java`          | View (JSP) logic                                       |
| `NoteRestController.java`          | REST API controller for Swagger/Postman testing        |
| `NoteService.java`                 | Central business logic for notes                       |
| `NoteRepository.java`              | JPA DAO for notes                                      |
| `Note.java`                        | Note entity                                            |
| `webapp/jsp/*.jsp`                 | JSP views (one per operation)                          |
| `webapp/css/style.css`             | Global themed styles (light/dark mode)                 |
| `webapp/js/theme-toggle.js`        | Handles theme switching logic                          |
| `project-journal.md`               | This changelog and planning document                   |
| `application-local.properties`     | DB & server config                                     |

---

## 🔍 Observations & Best Practices

- Having **REST and JSP modes** coexist helps test backend logic from both UI and tools like Swagger.
- Naming conventions (e.g., `noteId`, `filename`) are consistent across layers.
- Controller logic avoids duplication by abstracting validation and error handling properly.
- JSPs are designed to **stay on the same view** post-action (upload/update/delete) for better UX.

---

## 📅 Timeline Snapshot

| Feature                             | Status       |
|-------------------------------------|--------------|
| CRUD + File Upload                  | ✅ Completed |
| JSP Frontend Integration            | ✅ Completed |
| Modal-based Feedback (UX)           | ✅ Completed |
| Theme Switching (Light/Dark)        | ✅ Completed |
| Single Note Download                | ✅ Completed |
| Bulk ZIP Download                   | ✅ Completed |
| Filename Conflict Handling          | ✅ Completed |
| Error Feedback on Fetch             | ✅ Completed |
| Tag, Trash, Folder System           | 🔜 Planned   |
| AI Writing Assistant                | 🔜 Planned   |

---

> _“This file is a living journal — a reflection of how the Notepad App is evolving from scratch into a powerful productivity platform.”_
