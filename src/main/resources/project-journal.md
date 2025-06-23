# Project: Notepad Application (Spring Boot + MySQL + JSP)

A full-stack Notepad web application with a modern UI/UX, built using Spring Boot, Hibernate (JPA), MySQL, and JSP. It supports secure user authentication, file upload, CRUD operations, download (single/bulk), theming, soft delete via trash, and dashboard navigation. Recent updates include search, confirm password, cascade delete, and full JSP redesigns.

---

## ✅ What Went Well

- **Modular Design**
  Clear separation between controller, service, repository, and entity layers ensured maintainability.

- **Session-Based Authentication**
  User login state managed via session attributes (`userId`, `username`).

- **Full CRUD Support**
  Notes can be created, updated, deleted (soft/permanent), and fetched by ID or filename.

- **File Upload (Single .txt)**
  Users can upload `.txt` files with optional custom filenames, extension normalization, and special character validation.

- **Download Support**
  Users can download notes individually or bulk-download all as a `.zip`.

- **Trash Panel**
  Deleted notes move to trash with timestamp; can be restored or deleted permanently.

- **Dashboard Revamp**
  The dashboard now features responsive cards, hover effects, and better layout management.

- **Theme Toggle (Light/Dark + More)**
  Multiple themes (light, dark, rose, lavender, aqua) using CSS variables and `<select>`-based toggle.

- **JSP-Wide Modal Support**
  All forms/actions now give modal-based feedback with contextual options like “Stay Here” and “Go to Dashboard”.

- **Cascade Delete**
  Deleting a user now removes all their notes and trashed entries automatically.

- **Confirm Password Support**
  Added confirm password validation during registration to ensure better UX.

- **Client-Side Search (All Notes)**
  Search bar added to filter notes by filename directly on the UI without hitting the server.

- **Fully Refactored JSPs**
  All pages (create, delete, update, fetch, upload, register, trash, etc.) now follow modern layout, spacing, and font styling for a professional experience.

---

## ❌ What Went Wrong / Fixes Applied

- **Inconsistent File Handling**
  Fixed filename extension appending logic and duplication issues using central helper logic.

- **Poor Modal Design Early On**
  Refactored all modal boxes with padding, spacing, and better button placement using flexbox.

- **Trash Date Missing**
  Previously, deletedAt timestamps were not rendered due to missing `<fmt:formatDate>` taglib. This was corrected.

- **Overflow in Note Content**
  Added proper wrapping, scrolling, and structure in note content containers (`<pre>`) to avoid horizontal scrolling.

- **Account Delete Left Notes Behind**
  Initially, user notes remained even after account deletion. This is now fixed using proper cascade behavior at DB and entity level.

---

## 🧱 Problems We Overcame

- ✅ Uniform modal logic across all actions.
- ✅ Style overhaul with responsive containers, adaptive spacing.
- ✅ Note search implemented fully in frontend (client-side search).
- ✅ Confirm password validation logic added in both backend and JSP.
- ✅ Cascade delete via `orphanRemoval = true` and `@OneToMany` relationship.
- ✅ Content overflow fix in fetch-by-ID and fetch-by-filename JSPs.
- ✅ Fixed trash note timestamp visibility via proper JSTL formatting.

---

## 🌱 Roadmap Ahead

### 📥 Import & Upload

- **Bulk Upload from ZIP (with unique .txt files)** 🔜  
  Users can upload multiple text files at once.

- **File Validation**  
  Ensure `.txt` extension and uniqueness before accepting uploaded files.

### 📦 Bulk Operations

- **Checkbox-Based Bulk Select** 🔜  
  Add support in All Notes and Trash views for selecting multiple notes.

- **Bulk Download (Selective)**  
  Selected notes to be downloaded as a `.zip` (single file = `.txt`).

- **Bulk Delete (All Notes)**  
  Move selected notes to trash.

- **Bulk Restore / Delete (Trash)**  
  Restore or permanently delete selected trashed notes.

### ✍️ UI Enhancements

- Add subtle tooltips, animations, and accessibility improvements.
- Add help text or short instructions above complex features (like bulk actions).

### 🧠 AI Assistant (Post-MVP)

- Let user type a prompt like “summarize India’s freedom struggle” and the app auto-generates a note using GPT.

---

## 💻 UI Development Tracker

| Feature                                | Status       |
|----------------------------------------|--------------|
| Dashboard Layout (Cards + Grid)        | ✅ Completed |
| Theme Toggle with CSS Variables        | ✅ Completed |
| Create / Update / Delete Notes         | ✅ Completed |
| Upload Single Note                     | ✅ Completed |
| Fetch by ID / Filename                 | ✅ Completed |
| Download Note (.txt)                   | ✅ Completed |
| Download All Notes (.zip)              | ✅ Completed |
| Trash + Restore + Permanent Delete     | ✅ Completed |
| Confirm Password on Register           | ✅ Completed |
| Cascade Delete on Account Removal      | ✅ Completed |
| Search Notes (UI Only)                 | ✅ Completed |
| Modal Feedback System                  | ✅ Completed |
| JSP Layout Refactor                    | ✅ Completed |
| Bulk Upload from ZIP                   | 🔜 Planned   |
| Checkbox Bulk Operations               | 🔜 Planned   |
| AI Writing Assistant                   | 🔜 Future    |

---

## 📦 File Structure Highlights

| File/Folder                      | Description                                  |
|----------------------------------|----------------------------------------------|
| `/entity/Note.java`             | Note entity (with userId & filename)         |
| `/entity/TrashedNote.java`      | Soft-deleted notes entity                    |
| `/entity/UserData.java`         | Registered user info                         |
| `/service/NoteService.java`     | Core note logic                              |
| `/service/UserService.java`     | User create/login/delete logic               |
| `/repository/*Repository.java`  | JPA interfaces for DB access                 |
| `/jsp/*.jsp`                    | All user-facing views                        |
| `/css/style.css`                | Core stylesheet with theme variables         |
| `/js/theme.js`                  | JS theme switcher                            |

---

## 📅 Timeline Snapshot

| Feature                        | Status       |
|--------------------------------|--------------|
| Base CRUD + Upload             | ✅ Completed |
| Download (Single & Bulk)       | ✅ Completed |
| Trash + Restore System         | ✅ Completed |
| Theming                        | ✅ Completed |
| Registration Improvements      | ✅ Completed |
| Cascading Deletion             | ✅ Completed |
| UI-Wide Modal Feedback         | ✅ Completed |
| Search Bar (UI-Level)          | ✅ Completed |
| Bulk Actions (Checkbox)        | 🔜 Next Up   |
| Bulk ZIP Upload                | 🔜 Next Up   |
| AI Note Assistant              | 🔜 Future    |

---

> _“This journal documents the journey from a basic CRUD app to a polished, user-friendly notepad platform.”_
