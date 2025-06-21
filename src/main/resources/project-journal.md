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
  Professional modals implemented for create, update, delete, upload, restore, and register actions — delivering clean and contextual feedback post-success.

- **Download Feature (Single & Bulk)**  
  Users can:
  - Download individual notes by ID or filename as `.txt`.
  - Bulk-download all notes as `.zip`.

- **Trash Panel (Soft Delete + Restore)**  
  Trashed notes moved to a dedicated view for recovery or permanent deletion, with themed modals and confirmations.

- **Theme Toggle**  
  Multiple color themes (Light, Dark, Rose, Lavender, Aqua) with smooth switching using CSS variables and JS sync.

- **Dashboard UI Redesign**  
  Converted dashboard to a responsive, modern grid layout using dashboard cards and adaptive spacing.

- **Universal Modal Support with Stay/Go Logic**  
  All modals now include "Stay Here" and "Go to Dashboard" buttons for improved UX continuity.

---

## ❌ What Went Wrong / Impediments

- **Filename Discrepancies**  
  Some flows appended `.txt`, while others didn’t — causing silent duplicates. Fixed with centralized logic.

- **Lack of Feedback on JSP Pages**  
  Many early pages showed no confirmation/error, confusing users about the result of their actions.

- **Modal Layout Bugs**  
  Modal buttons used to overflow or stack awkwardly — now fixed using responsive flex layout.

- **Notes Not Centering**  
  On wider screens, incomplete rows of dashboard cards looked unbalanced. Fixed with auto-centering logic.

- **Account Deletion Missing Note Cleanup**  
  Deleting a user account did not remove their notes. To be fixed in the next phase.

---

## 🧱 Impediments We Overcame

- **Consistent `.txt` Extension Logic**  
  Introduced `normalizeTxtExtension()` to apply rules consistently across all CRUD and upload flows.

- **Modal Button UX Upgrade**  
  Modals now include two-choice buttons (`Stay Here`, `Go to Dashboard`) and uniform styling.

- **Trash View Table Styling**  
  Restyled the trash view table layout, made it mobile-responsive and added clear action buttons.

- **Dashboard Pro UX Overhaul**  
  Grid-based responsive layout with hover effects and backdrop styling elevated the professional look.

- **Proper Redirect on Registration**  
  Registration now triggers a modal success message with a clean "Login" redirection path.

---

## 🌱 Future Enhancements / Upgrade Ideas

### 🔧 Backend Enhancements
- **Cascade Delete Notes on Account Deletion** 🔜  
  Ensure all notes and trashed items of a user are deleted when account is removed.  
  ➕ Add a warning message in modal for this consequence.

- **Note Versioning**  
  Maintain edit history with rollback support.

- **Tagging and Folders**  
  Logical grouping for better note organization.

- **Note Analytics**  
  Show word counts, last updated date, etc.

- **Audit Logs**  
  Track login, edits, deletions, and downloads.

### 🔐 Security & Access
- **Role-Based Access Control**  
  Add support for ADMIN, MODERATOR in future.

### 📥 Import / Export
- **Import ZIP**  
  Bulk upload `.txt` files via ZIP.

- **Export Metadata**  
  Export filename/content info as CSV or JSON.

### 🧠 AI Integration (Post-MVP)
- **AI Assistant for Writing**  
  GPT-powered assistant for writing content directly from prompts.

### 💡 UI Improvements
- **Upgrade All JSP Views** 🔜  
  Make all JSPs consistent with the new dashboard style.

- **Text Wrapping Fix on Fetch** 🔜  
  Prevent overflow issues for large content fetched by ID/filename.

- **Add Introductory Paragraphs on JSPs** 🔜  
  Add short context descriptions to help non-technical users understand each feature.

---

## 💻 UI Development Tracker

| Feature                         | Status       |
|----------------------------------|--------------|
| Login & Session Auth             | ✅ Completed |
| Dashboard (Pro Design)           | ✅ Completed |
| Create / Update / Delete Views  | ✅ Completed |
| Upload Form                      | ✅ Completed |
| Fetch by ID / Filename           | ✅ Completed |
| Download Single Note             | ✅ Completed |
| Download All as ZIP              | ✅ Completed |
| Sort + Expand in All Notes View  | ✅ Completed |
| Modal-based Success Messages     | ✅ Completed |
| Stay/Go Buttons in Modals        | ✅ Completed |
| Trash / Restore Panel            | ✅ Completed |
| Dynamic Theme Support            | ✅ Completed |
| Role-Based Access                | 🔜 Planned   |
| Cascade Delete on Account Delete| 🔜 Planned   |
| Overflow/Text Wrapping Fixes     | 🔜 Planned   |
| Tag, Folder, Search UI           | 🔜 Planned   |
| AI Note Assistant                | 🔜 Planned   |

---

## 📦 File Structure & Conventions

| File/Directory                      | Purpose                                                |
|------------------------------------|--------------------------------------------------------|
| `NoteViewController.java`          | JSP view logic                                         |
| `NoteRestController.java`          | REST endpoints for testing                             |
| `NoteService.java`                 | Business logic                                         |
| `NoteRepository.java`              | JPA DAO                                                |
| `Note.java`                        | Main entity                                            |
| `TrashedNote.java`                 | Soft-deleted notes entity                              |
| `webapp/jsp/*.jsp`                 | JSP views per operation                                |
| `webapp/css/style.css`             | Global themed styles with theme variables              |
| `webapp/js/theme.js`               | Handles dropdown theme logic                           |
| `project-journal.md`               | Developer changelog                                    |

---

## 📅 Timeline Snapshot

| Feature                             | Status       |
|-------------------------------------|--------------|
| CRUD + Upload                       | ✅ Completed |
| Modal-based Feedback                | ✅ Completed |
| Theme Support                       | ✅ Completed |
| Trash / Restore                     | ✅ Completed |
| Pro Dashboard Layout                | ✅ Completed |
| JSP UI Refactor (All)               | 🔜 Next Up   |
| Data Cleanup on Account Deletion    | 🔜 Next Up   |
| Responsive Fix for Fetch Views      | 🔜 Next Up   |
| AI Assistant                        | 🔜 Future    |

---

> _“This file is a living journal — a reflection of how the Notepad App is evolving from scratch into a powerful productivity platform.”_
