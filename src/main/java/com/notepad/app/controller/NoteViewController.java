package com.notepad.app.controller;

import com.notepad.app.entity.Note;
import com.notepad.app.service.NoteService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.Optional;

@Controller
public class NoteViewController {

    @Autowired
    private NoteService noteService;

    private boolean isNotLoggedIn(HttpSession session) {
        return session.getAttribute("userId") == null;
    }

    @GetMapping("/dashboard")
    public String showDashboard(HttpSession session, Model model) {
        if (isNotLoggedIn(session)) return "login";

        Long userId = (Long) session.getAttribute("userId");
        model.addAttribute("notes", noteService.getAllNotesByUser(userId));
        model.addAttribute("username", session.getAttribute("username"));
        return "dashboard";
    }

    // ===================== CREATE NOTE =====================

    @GetMapping("/note/create")
    public String showCreateNoteForm() {
        return "createNote";
    }

    @PostMapping("/note/create")
    public String handleCreateNote(@RequestParam String filename,
                                   @RequestParam String content,
                                   HttpSession session,
                                   Model model) {
        if (isNotLoggedIn(session)) return "login";

        Note note = new Note();
        note.setUserId((Long) session.getAttribute("userId"));
        note.setFilename(filename);
        note.setContent(content);
        note.setUserType("USER");

        noteService.createNote(note);
        model.addAttribute("message", "Note created successfully.");
        return "dashboard";
    }

    // ===================== UPLOAD NOTE FILE =====================

    @GetMapping("/note/upload")
    public String showUploadForm() {
        return "uploadNote";
    }

    @PostMapping("/note/upload")
    public String handleFileUpload(@RequestParam MultipartFile file,
                                   @RequestParam(required = false) String filename,
                                   HttpSession session,
                                   Model model) {
        if (isNotLoggedIn(session)) return "login";

        if (file.isEmpty() || !file.getOriginalFilename().endsWith(".txt")) {
            model.addAttribute("error", "Invalid file. Only .txt allowed.");
            return "uploadNote";
        }

        try {
            Long userId = (Long) session.getAttribute("userId");
            String finalFilename = (filename != null && !filename.isBlank()) ? filename : file.getOriginalFilename();

            if (!finalFilename.endsWith(".txt")) finalFilename += ".txt";

            Note note = new Note();
            note.setUserId(userId);
            note.setFilename(finalFilename);
            note.setContent(new String(file.getBytes()));
            note.setUserType("USER");

            noteService.createNote(note);
            model.addAttribute("message", "File uploaded as note.");
            return "dashboard";

        } catch (Exception e) {
            model.addAttribute("error", "Error: " + e.getMessage());
            return "uploadNote";
        }
    }

    // ===================== FETCH NOTES =====================

    @GetMapping("/note/fetch/by-id")
    public String showFetchByIdForm() {
        return "fetchById";
    }

    @PostMapping("/note/fetch/by-id")
    public String fetchNoteById(@RequestParam Long noteId,
                                HttpSession session,
                                Model model) {
        if (isNotLoggedIn(session)) return "login";

        Long userId = (Long) session.getAttribute("userId");
        Optional<Note> note = noteService.getNoteById(noteId);

        if (note.isPresent() && note.get().getUserId().equals(userId)) {
            model.addAttribute("note", note.get());
            return "noteDetails";
        } else {
            model.addAttribute("error", "Note not found or unauthorized.");
            return "fetchById";
        }
    }

    @GetMapping("/note/fetch/by-filename")
    public String showFetchByFilenameForm() {
        return "fetchByFilename";
    }

    @PostMapping("/note/fetch/by-filename")
    public String fetchNoteByFilename(@RequestParam String filename,
                                      HttpSession session,
                                      Model model) {
        if (isNotLoggedIn(session)) return "login";

        Long userId = (Long) session.getAttribute("userId");
        Optional<Note> note = noteService.getNoteByFilenameAndUserId(filename, userId);

        if (note.isPresent()) {
            model.addAttribute("note", note.get());
            return "noteDetails";
        } else {
            model.addAttribute("error", "Note not found or unauthorized.");
            return "fetchByFilename";
        }
    }

    @GetMapping("/note/fetch/all")
    public String fetchAllNotes(HttpSession session, Model model) {
        if (isNotLoggedIn(session)) return "login";

        Long userId = (Long) session.getAttribute("userId");
        model.addAttribute("notes", noteService.getAllNotesByUser(userId));
        return "allNotes";
    }

    // ===================== UPDATE NOTES =====================

    @GetMapping("/note/update/by-id")
    public String showUpdateByIdForm() {
        return "updateById";
    }

    @PostMapping("/note/update/by-id")
    public String handleUpdateById(@RequestParam Long noteId,
                                   @RequestParam String filename,
                                   @RequestParam String content,
                                   HttpSession session,
                                   Model model) {
        if (isNotLoggedIn(session)) return "login";

        Optional<Note> existing = noteService.getNoteById(noteId);
        if (existing.isPresent() && existing.get().getUserId().equals(session.getAttribute("userId"))) {
            Note note = existing.get();
            note.setFilename(filename);
            note.setContent(content);
            noteService.updateNote(note);
            model.addAttribute("message", "Note updated successfully.");
            return "dashboard";
        } else {
            model.addAttribute("error", "Note not found or unauthorized.");
            return "updateById";
        }
    }

    @GetMapping("/note/update/by-filename")
    public String showUpdateByFilenameForm() {
        return "updateByFilename";
    }

    @PostMapping("/note/update/by-filename")
    public String handleUpdateByFilename(@RequestParam String filename,
                                         @RequestParam String content,
                                         HttpSession session,
                                         Model model) {
        if (isNotLoggedIn(session)) return "login";

        Long userId = (Long) session.getAttribute("userId");
        Optional<Note> existing = noteService.getNoteByFilenameAndUserId(filename, userId);

        if (existing.isPresent()) {
            Note note = existing.get();
            note.setContent(content);
            noteService.updateNote(note);
            model.addAttribute("message", "Note updated successfully.");
            return "dashboard";
        } else {
            model.addAttribute("error", "Note not found or unauthorized.");
            return "updateByFilename";
        }
    }

    // ===================== DELETE NOTES =====================

    @GetMapping("/note/delete/by-id")
    public String showDeleteByIdForm() {
        return "deleteById";
    }

    @PostMapping("/note/delete/by-id")
    public String handleDeleteById(@RequestParam Long noteId,
                                   HttpSession session,
                                   Model model) {
        if (isNotLoggedIn(session)) return "login";

        Optional<Note> note = noteService.getNoteById(noteId);
        if (note.isPresent() && note.get().getUserId().equals(session.getAttribute("userId"))) {
            noteService.deleteNoteById(noteId);
            model.addAttribute("message", "Note deleted successfully.");
            return "dashboard";
        } else {
            model.addAttribute("error", "Note not found or unauthorized.");
            return "deleteById";
        }
    }

    @GetMapping("/note/delete/by-filename")
    public String showDeleteByFilenameForm() {
        return "deleteByFilename";
    }

    @PostMapping("/note/delete/by-filename")
    public String handleDeleteByFilename(@RequestParam String filename,
                                         HttpSession session,
                                         Model model) {
        if (isNotLoggedIn(session)) return "login";

        Long userId = (Long) session.getAttribute("userId");
        Optional<Note> note = noteService.getNoteByFilenameAndUserId(filename, userId);

        if (note.isPresent()) {
            noteService.deleteNoteById(note.get().getId());
            model.addAttribute("message", "Note deleted successfully.");
            return "dashboard";
        } else {
            model.addAttribute("error", "Note not found or unauthorized.");
            return "deleteByFilename";
        }
    }
}
