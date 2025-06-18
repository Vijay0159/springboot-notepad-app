package com.notepad.app.controller;

import com.notepad.app.entity.Note;
import com.notepad.app.service.NoteService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;
import java.util.List;

@RestController
@RequestMapping("/notes")
public class NoteController {

    @Autowired
    private NoteService noteService;

    // DTO for note input
    static class NoteRequestDTO {
        public String filename;
        public String content;
        public String userType; // optional
    }

    @Operation(summary = "Create a new note", description = "Creates a note for the logged-in user.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Note created"),
            @ApiResponse(responseCode = "401", description = "User not authenticated")
    })
    @PostMapping("/create")
    public ResponseEntity<?> createNote(HttpSession session, @RequestBody NoteRequestDTO req) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();

        Note note = new Note();
        note.setUserId(userId);
        note.setFilename(req.filename);
        note.setContent(req.content);
        note.setUserType(req.userType != null ? req.userType : "USER");

        return ResponseEntity.ok(noteService.createNote(note));
    }

    @Operation(summary = "Get all notes", description = "Retrieves all notes for the logged-in user.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Notes retrieved"),
            @ApiResponse(responseCode = "401", description = "User not authenticated")
    })
    @GetMapping("/all")
    public ResponseEntity<List<Note>> getNotes(HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        return ResponseEntity.ok(noteService.getAllNotesByUser(userId));
    }

    @Operation(summary = "Get note by ID", description = "Retrieves a specific note by ID, only if it belongs to the user.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Note found"),
            @ApiResponse(responseCode = "404", description = "Note not found")
    })
    @GetMapping("/get/{noteId}")
    public ResponseEntity<Object> getNote(@PathVariable Long noteId, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        Optional<Note> noteOpt = noteService.getNoteById(noteId);
        if (noteOpt.isPresent() && noteOpt.get().getUserId().equals(userId)) {
            return ResponseEntity.ok(noteOpt.get());
        }
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Note not found or unauthorized");
    }

    @Operation(summary = "Update a note", description = "Updates an existing note if it belongs to the user.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Note updated"),
            @ApiResponse(responseCode = "401", description = "Unauthorized"),
            @ApiResponse(responseCode = "404", description = "Note not found")
    })
    @PutMapping("/update/{noteId}")
    public ResponseEntity<?> updateNote(@PathVariable Long noteId, @RequestBody NoteRequestDTO req, HttpSession session) {
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

    @Operation(summary = "Delete a note", description = "Deletes a note by ID if it belongs to the logged-in user.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Note deleted"),
            @ApiResponse(responseCode = "401", description = "Unauthorized"),
            @ApiResponse(responseCode = "404", description = "Note not found")
    })
    @DeleteMapping("/delete/{noteId}")
    public ResponseEntity<?> deleteNote(@PathVariable Long noteId, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        Optional<Note> note = noteService.getNoteById(noteId);
        if (note.isPresent() && note.get().getUserId().equals(userId)) {
            noteService.deleteNoteById(noteId);
            return ResponseEntity.ok("Note deleted");
        }
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Note not found or unauthorized");
    }
}
