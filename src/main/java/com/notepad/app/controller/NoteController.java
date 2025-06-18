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
import org.springframework.web.multipart.MultipartFile;

import java.util.Optional;

@RestController
@RequestMapping("/notes")
public class NoteController {

    @Autowired
    private NoteService noteService;

    static class NoteRequestDTO {
        public String filename;
        public String content;
        public String userType;
    }

    private boolean isNotLoggedIn(HttpSession session) {
        return session.getAttribute("userId") == null;
    }

    @Operation(summary = "Create a note", description = "Creates a new note associated with the current logged-in user.")
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "Note created successfully"),
            @ApiResponse(responseCode = "401", description = "Login required")
    })
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

    @Operation(summary = "Get all notes", description = "Retrieves all notes created by the logged-in user.")
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "Notes retrieved successfully"),
            @ApiResponse(responseCode = "401", description = "Login required")
    })
    @GetMapping("/all")
    public ResponseEntity<?> getNotes(HttpSession session) {
        if (isNotLoggedIn(session)) return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Login before viewing notes");

        Long userId = (Long) session.getAttribute("userId");
        return ResponseEntity.ok(noteService.getAllNotesByUser(userId));
    }

    @Operation(summary = "Get note by ID", description = "Fetches a specific note by its ID, only if it belongs to the logged-in user.")
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "Note retrieved successfully"),
            @ApiResponse(responseCode = "404", description = "Note not found or unauthorized"),
            @ApiResponse(responseCode = "401", description = "Login required")
    })
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

    @Operation(summary = "Update note by ID", description = "Updates a note identified by ID for the current user.")
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "Note updated successfully"),
            @ApiResponse(responseCode = "401", description = "Unauthorized or login required"),
            @ApiResponse(responseCode = "404", description = "Note not found")
    })
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

    @Operation(summary = "Delete note by ID", description = "Deletes a note identified by ID, if it belongs to the current user.")
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "Note deleted successfully"),
            @ApiResponse(responseCode = "404", description = "Note not found or unauthorized"),
            @ApiResponse(responseCode = "401", description = "Login required")
    })
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

    @Operation(
            summary = "Get note by filename",
            description = "Fetch a specific note by filename for the currently logged-in user"
    )
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "Note fetched successfully"),
            @ApiResponse(responseCode = "401", description = "User not logged in"),
            @ApiResponse(responseCode = "404", description = "Note not found or unauthorized")
    })
    @GetMapping("/get/by-filename/{filename}")
    public ResponseEntity<?> getNoteByFilename(@PathVariable String filename, HttpSession session) {
        if (session.getAttribute("userId") == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Login before viewing note");
        }

        Long userId = (Long) session.getAttribute("userId");
        Optional<Note> noteOpt = noteService.getNoteByFilenameAndUserId(filename, userId);

        if (noteOpt.isPresent()) {
            return ResponseEntity.ok(noteOpt.get());
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Note not found or unauthorized");
        }
    }



    @Operation(summary = "Update note by filename", description = "Updates an existing note using its filename.")
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "Note updated successfully"),
            @ApiResponse(responseCode = "404", description = "Note not found"),
            @ApiResponse(responseCode = "401", description = "Login required")
    })
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

    @Operation(summary = "Delete note by filename", description = "Deletes a note by filename if it belongs to the current user.")
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "Note deleted successfully"),
            @ApiResponse(responseCode = "404", description = "Note not found"),
            @ApiResponse(responseCode = "401", description = "Login required")
    })
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

    @Operation(summary = "Upload note from file", description = "Uploads a `.txt` file and saves it as a note for the user.")
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "Note uploaded successfully"),
            @ApiResponse(responseCode = "400", description = "Invalid file or filename"),
            @ApiResponse(responseCode = "401", description = "Login required"),
            @ApiResponse(responseCode = "500", description = "Server error while processing the file")
    })
    @PostMapping(value = "/upload", consumes = "multipart/form-data")
    public ResponseEntity<?> uploadNoteFile(
            HttpSession session,
            @RequestPart("file") MultipartFile file,
            @RequestPart(value = "filename", required = false) String filename,
            @RequestPart(value = "userType", required = false) String userType
    ) {
        if (session.getAttribute("userId") == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Login before uploading note");
        }

        if (file.isEmpty() || !file.getOriginalFilename().endsWith(".txt")) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid or empty file. Only .txt files allowed.");
        }

        try {
            Long userId = (Long) session.getAttribute("userId");
            String finalFilename = (filename != null && !filename.trim().isEmpty())
                    ? filename.trim()
                    : file.getOriginalFilename();

            if (finalFilename.contains("/") || finalFilename.contains("\\") || finalFilename.startsWith(".")) {
                return ResponseEntity.badRequest().body("Filename cannot contain slashes or start with a dot.");
            }

            long dotCount = finalFilename.chars().filter(ch -> ch == '.').count();
            if (dotCount > 1) {
                return ResponseEntity.badRequest().body("Filename cannot contain more than one dot.");
            }

            if (!finalFilename.endsWith(".txt")) {
                finalFilename += ".txt";
            }

            Note note = new Note();
            note.setUserId(userId);
            note.setFilename(finalFilename);
            note.setUserType(userType != null ? userType : "USER");
            note.setContent(new String(file.getBytes()));

            return ResponseEntity.ok(noteService.createNote(note));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Failed to upload note: " + e.getMessage());
        }
    }
}
