package com.notepad.app.controller;

import com.notepad.app.entity.Note;
import com.notepad.app.service.NoteService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequestMapping("/notes")
public class NoteController {

    @Autowired
    private NoteService noteService;

    static class NoteRequestDTO {
        public String filename;
        public String content;
        public String userType; // optional
    }

    private boolean isNotLoggedIn(HttpSession session) {
        return session.getAttribute("userId") == null;
    }

    @PostMapping("/create")
    public ResponseEntity<?> createNote(HttpSession session, @RequestBody NoteRequestDTO req) {
        if (isNotLoggedIn(session)) return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Login before creating a note");

        Long userId = (Long) session.getAttribute("userId");
        Note note = new Note();
        note.setUserId(userId);
        note.setFilename(req.filename);
        note.setContent(req.content);
        note.setUserType(req.userType != null ? req.userType : "USER");

        return ResponseEntity.ok(noteService.createNote(note));
    }

    @GetMapping("/all")
    public ResponseEntity<?> getNotes(HttpSession session) {
        if (isNotLoggedIn(session)) return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Login before viewing notes");

        Long userId = (Long) session.getAttribute("userId");
        return ResponseEntity.ok(noteService.getAllNotesByUser(userId));
    }

    @GetMapping("/get/by-id/{noteId}")
    public ResponseEntity<?> getNote(@PathVariable Long noteId, HttpSession session) {
        if (isNotLoggedIn(session)) return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Login before viewing note");

        Long userId = (Long) session.getAttribute("userId");
        Optional<Note> noteOpt = noteService.getNoteById(noteId);
        if (noteOpt.isPresent() && noteOpt.get().getUserId().equals(userId)) {
            return ResponseEntity.ok(noteOpt.get());
        }
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Note not found or unauthorized");
    }

    @PutMapping("/update/by-id/{noteId}")
    public ResponseEntity<?> updateNote(@PathVariable Long noteId, @RequestBody NoteRequestDTO req, HttpSession session) {
        if (isNotLoggedIn(session)) return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Login before updating note");

        Long userId = (Long) session.getAttribute("userId");
        Optional<Note> existing = noteService.getNoteById(noteId);
        if (existing.isEmpty() || !existing.get().getUserId().equals(userId)) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Unauthorized or note not found");
        }

        Note note = existing.get();
        note.setFilename(req.filename);
        note.setContent(req.content);
        if (req.userType != null) note.setUserType(req.userType);

        return ResponseEntity.ok(noteService.updateNote(note));
    }

    @DeleteMapping("/delete/by-id/{noteId}")
    public ResponseEntity<?> deleteNote(@PathVariable Long noteId, HttpSession session) {
        if (isNotLoggedIn(session)) return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Login before deleting note");

        Long userId = (Long) session.getAttribute("userId");
        Optional<Note> note = noteService.getNoteById(noteId);
        if (note.isPresent() && note.get().getUserId().equals(userId)) {
            noteService.deleteNoteById(noteId);
            return ResponseEntity.ok("Note deleted");
        }
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Note not found or unauthorized");
    }

    // ---------------- NEW: by filename ----------------

    @GetMapping("/get/by-filename/{filename}")
    public ResponseEntity<?> getNoteByFilename(@PathVariable String filename, HttpSession session) {
        if (isNotLoggedIn(session)) return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Login before viewing note");

        Long userId = (Long) session.getAttribute("userId");
        Optional<Note> noteOpt = noteService.getNoteByFilenameAndUserId(filename, userId);
        if (noteOpt.isPresent()) {
            return ResponseEntity.ok(noteOpt.get());
        }
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Note not found or unauthorized");
    }

    @PutMapping("/update/by-filename/{filename}")
    public ResponseEntity<?> updateNoteByFilename(@PathVariable String filename, @RequestBody NoteRequestDTO req, HttpSession session) {
        if (isNotLoggedIn(session)) return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Login before updating note");

        Long userId = (Long) session.getAttribute("userId");
        Optional<Note> existing = noteService.getNoteByFilenameAndUserId(filename, userId);
        if (existing.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Note not found or unauthorized");
        }

        Note note = existing.get();
        note.setFilename(req.filename);
        note.setContent(req.content);
        if (req.userType != null) note.setUserType(req.userType);

        return ResponseEntity.ok(noteService.updateNote(note));
    }

    @DeleteMapping("/delete/by-filename/{filename}")
    public ResponseEntity<?> deleteNoteByFilename(@PathVariable String filename, HttpSession session) {
        if (isNotLoggedIn(session)) return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Login before deleting note");

        Long userId = (Long) session.getAttribute("userId");
        Optional<Note> noteOpt = noteService.getNoteByFilenameAndUserId(filename, userId);
        if (noteOpt.isPresent()) {
            noteService.deleteNoteById(noteOpt.get().getId());
            return ResponseEntity.ok("Note deleted");
        }
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Note not found or unauthorized");
    }
}
