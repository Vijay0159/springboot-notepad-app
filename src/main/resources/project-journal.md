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
- **JSP UI Integrated**: A structured, themed frontend has been integrated with dedicated JSP views for all core operations (login, dashboard, fetch, update, delete, upload, etc.).
- **Theme Toggle Feature**: JavaScript-based light/dark theme toggle implemented, enhancing visual UX for users.
- **Navigation via Dashboard**: Hyperlink buttons styled and organized under grouped sections for all note-related operations.
- **REST + JSP Dual Mode**: REST controllers power Swagger API docs; view controllers serve JSP UI. Both coexist smoothly.

---

## ❌ What Went Wrong / Impediments

- **Swagger File Upload Glitch**: Swagger initially failed to render file upload UI due to incorrect `@RequestParam` usage.
- **File Naming Confusion**: Filenames were appended with `.txt` incorrectly or inconsistently; resolved with smart extension logic.
- **UI Rendering Gaps**: Some view transitions lacked feedback (success/error), and JSP form links mismatched controller paths early on.
- **JSP Tag Library Error**: JSTL functions (e.g., `fn:length`) failed until proper taglib imports were added.

---

## 🧱 Impediments We Overcame

- **Multipart Support in Swagger**: Resolved by replacing `@RequestParam` with `@RequestPart`, setting `consumes = multipart/form-data`.
- **Filename & Content Validation**: Custom logic added to validate filenames and ensure content is safe and not empty.
- **JSP Integration**: Unified REST and UI controllers. Ensured all JSPs correctly mapped and displayed appropriate data.
- **Themed UI with JS**: Created `theme-toggle.js` and `style.css` for consistent styling and toggling between themes.
- **Dynamic JSPs for All Ops**: Each operation (e.g., `/note/update/by-id`) has a dedicated view, improving clarity and usability.

---

## 🌱 Future Enhancements / Upgrade Ideas

### 🔧 Core Backend Upgrades
- **Versioning System**
- **Trash / Soft Delete**
- **Tagging & Categories**
- **Full-text Content Search**
- **Note Metadata**
- **Audit Logs**

### 🔐 Security and Access Control
- **Role-based Authorization**

### 📥 Import / Export Support
- **Export Notes** 🔜 (Next up!)
- **Import Notes**

### 📁 Folder Structure Support
- **Virtual Folders**

### ⏰ Reminders and Notifications
- **Timed Notes / Alerts**

---

## 💻 UI Development Plan (JSP / HTML)

| Feature                   | Status       |
|---------------------------|--------------|
| Login, Register, Logout   | ✅ Completed |
| Dashboard UI              | ✅ Completed |
| All CRUD Forms (JSP)      | ✅ Completed |
| Get All Notes View        | ✅ Completed |
| Note Details View         | ✅ Completed |
| Theme Toggle Button       | ✅ Completed |
| Feedback Messages (JSP)   | 🔜 Planned   |
| Download Buttons / Views  | 🔜 Planned   |
| Trash View                | 🔜 Planned   |
| Folder / Tag Filtering    | 🔜 Planned   |
| Reminder Panel            | 🔜 Planned   |

> Frontend is currently powered by JSP + custom CSS. May consider Bootstrap integration or React transition later.

---

## 📦 Project File Convention

| File                         | Purpose                                                     |
|-----------------------------|-------------------------------------------------------------|
| `application-local.properties` | Local DB and server config for dev use                    |
| `project-journal.md`        | This file: Documentation, changelog, retrospective & plans  |
| `NoteRestController.java`   | REST endpoints for note operations (for Swagger/API)        |
| `NoteViewController.java`   | UI handlers for JSP-based frontend                          |
| `NoteService.java`          | Business logic and validations                              |
| `NoteRepository.java`       | JPA interface to DB                                         |
| `Note.java`                 | JPA entity                                                  |
| `UserRestController.java`   | REST endpoints for auth                                     |
| `AuthViewController.java`   | UI handlers for login/register/delete JSPs                 |
| `/webapp/jsp/*.jsp`         | JSP pages for each UI function                             |
| `/webapp/css/style.css`     | Global CSS styles for all views                            |
| `/webapp/js/theme-toggle.js`| JS for theme switcher                                       |

---

## 🔍 Observations & Good Practices

- **JSP + REST hybrid** setup is now functioning smoothly.
- Clean file and folder organization helps locate logic/UI easily.
- All note operations are duplicated in both REST and UI flows, easing testing and future migration.
- Next UI improvement will include **Download / Export** functionality and improving **form feedback UX**.

---

## 📅 Timeline Summary

| Feature                             | Status       |
|-------------------------------------|--------------|
| Session-based User Auth             | ✅ Completed |
| CRUD by ID & Filename               | ✅ Completed |
| File Upload & Filename Validation   | ✅ Completed |
| Swagger Integration (with Multipart)| ✅ Completed |
| JSP Frontend for All Operations     | ✅ Completed |
| Theme Toggle for UI                 | ✅ Completed |
| Download / Export Notes             | 🔜 Planned   |
| Versioning + Trash                  | 🔜 Planned   |
| Tagging / Full-text Search          | 🔜 Planned   |
| Audit Logging                       | 🔜 Planned   |
| Role-based Authorization            | 🔜 Planned   |

---

> _“This file is a living journal — an honest mirror of how this Notepad evolved, matured, and what's coming next.”_
