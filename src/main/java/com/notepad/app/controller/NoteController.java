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

    @PostMapping("/create")
    public ResponseEntity<?> createNote(HttpSession session, @RequestBody Note note) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();

        note.setUserId(userId);
        if (note.getUserType() == null) note.setUserType("USER");

        return ResponseEntity.ok(noteService.createNote(note));
    }

    @GetMapping("/")
    public ResponseEntity<?> getNotes(HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        return ResponseEntity.ok(noteService.getAllNotesByUser(userId));
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getNote(@PathVariable Long id, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        return noteService.getNoteById(id)
                .filter(note -> note.getUserId().equals(userId))
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.status(HttpStatus.NOT_FOUND).build());
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updateNote(@PathVariable Long id, @RequestBody Note note, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        if (!note.getUserId().equals(userId)) return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        note.setId(id);
        return ResponseEntity.ok(noteService.updateNote(note));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteNote(@PathVariable Long id, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        Optional<Note> note = noteService.getNoteById(id);
        if (note.isPresent() && note.get().getUserId().equals(userId)) {
            noteService.deleteNoteById(id);
            return ResponseEntity.ok("Note deleted");
        }
        return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
    }
}
