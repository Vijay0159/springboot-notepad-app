package com.notepad.app.controller;

import com.notepad.app.entity.Note;
import com.notepad.app.service.NoteService;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import jakarta.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;

@Controller
public class NoteViewController {

    @Autowired
    private NoteService noteService;

    private boolean isNotLoggedIn(HttpSession session) {
        return session.getAttribute("userId") == null;
    }

    private String normalizeTxtExtension(String filename) {
        return filename != null && !filename.toLowerCase().endsWith(".txt") ? filename + ".txt" : filename;
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

        Long userId = (Long) session.getAttribute("userId");
        String finalFilename = normalizeTxtExtension(filename);

        if (noteService.getNoteByFilenameAndUserId(finalFilename, userId).isPresent()) {
            model.addAttribute("error", "A note with that filename already exists.");
            return "createNote";
        }

        Note note = new Note();
        note.setUserId(userId);
        note.setFilename(finalFilename);
        note.setContent(content);
        note.setUserType("USER");

        noteService.createNote(note);
        model.addAttribute("noteCreated", true);
        model.addAttribute("filename", finalFilename);
        return "createNote";
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
            model.addAttribute("error", "Only .txt files are supported.");
            return "uploadNote";
        }

        try {
            Long userId = (Long) session.getAttribute("userId");
            String finalFilename = normalizeTxtExtension(
                    (filename != null && !filename.isBlank()) ? filename : file.getOriginalFilename()
            );

            if (noteService.getNoteByFilenameAndUserId(finalFilename, userId).isPresent()) {
                model.addAttribute("error", "A note with that filename already exists.");
                return "uploadNote";
            }

            Note note = new Note();
            note.setUserId(userId);
            note.setFilename(finalFilename);
            note.setContent(new String(file.getBytes()));
            note.setUserType("USER");

            noteService.createNote(note);
            model.addAttribute("uploadedFile", finalFilename);
            model.addAttribute("modalSuccess", true);
            return "uploadNote";

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
            model.addAttribute("note", note.get());  // ✅ Pass the note to JSP
        } else {
            model.addAttribute("error", "❌ No note found with that ID, or you don’t have access.");
        }

        return "fetchById"; // ✅ Always return this view (not noteDetails.jsp)
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
        String finalFilename = normalizeTxtExtension(filename);
        Optional<Note> note = noteService.getNoteByFilenameAndUserId(finalFilename, userId);

        if (note.isPresent()) {
            model.addAttribute("note", note.get());  // make note available to jsp
            return "fetchByFilename";                // ✅ use the same jsp
        } else {
            model.addAttribute("error", "❌ No note found with that filename, or you don’t have access.");
            return "fetchByFilename";
        }
    }




    @GetMapping("/note/fetch/all")
    public String fetchAllNotes(@RequestParam(required = false) String sortBy,
                                @RequestParam(required = false) String order,
                                HttpSession session,
                                Model model) {
        if (isNotLoggedIn(session)) return "login";

        Long userId = (Long) session.getAttribute("userId");
        List<Note> notes = noteService.getAllNotesByUser(userId);

        if ("filename".equals(sortBy)) {
            notes.sort(Comparator.comparing(Note::getFilename, String.CASE_INSENSITIVE_ORDER));
        } else {
            // default or if sortBy is "id"
            notes.sort(Comparator.comparing(Note::getId));
        }

        if ("desc".equalsIgnoreCase(order)) {
            Collections.reverse(notes);
        }

        model.addAttribute("notes", notes);
        model.addAttribute("sortBy", sortBy);
        model.addAttribute("order", order);
        return "allNotes";
    }

    @PostMapping("/note/download/all")
    public void downloadAllNotesAsZip(HttpSession session, HttpServletResponse response) {
        if (session.getAttribute("userId") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        Long userId = (Long) session.getAttribute("userId");
        List<Note> notes = noteService.getAllNotesByUser(userId);

        try (ByteArrayOutputStream baos = new ByteArrayOutputStream();
             ZipOutputStream zos = new ZipOutputStream(baos)) {

            for (Note note : notes) {
                String filename = note.getFilename();
                if (!filename.endsWith(".txt")) filename += ".txt";
                ZipEntry entry = new ZipEntry(filename);
                zos.putNextEntry(entry);
                zos.write(note.getContent().getBytes(StandardCharsets.UTF_8));
                zos.closeEntry();
            }

            zos.finish();

            response.setContentType("application/zip");
            response.setHeader("Content-Disposition", "attachment; filename=\"all-notes.zip\"");
            response.getOutputStream().write(baos.toByteArray());
            response.getOutputStream().flush();

        } catch (IOException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
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

        Long userId = (Long) session.getAttribute("userId");
        Optional<Note> existing = noteService.getNoteById(noteId);

        if (existing.isEmpty() || !existing.get().getUserId().equals(userId)) {
            model.addAttribute("error", "Note not found or unauthorized.");
            return "updateById";
        }

        if (noteService.isDuplicateFilenameForUserExceptId(filename, userId, noteId)) {
            model.addAttribute("error", "A note with that filename already exists.");
            return "updateById";
        }

        Note note = existing.get();
        note.setFilename(filename);
        note.setContent(content);
        noteService.updateNote(note);

        model.addAttribute("modalSuccess", true);
        model.addAttribute("updatedFile", filename);
        return "updateById";
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
        String finalFilename = normalizeTxtExtension(filename);
        Optional<Note> existing = noteService.getNoteByFilenameAndUserId(finalFilename, userId);

        if (existing.isEmpty()) {
            model.addAttribute("error", "Note not found or unauthorized.");
            return "updateByFilename";
        }

        Note note = existing.get();
        note.setContent(content);
        noteService.updateNote(note);

        model.addAttribute("modalSuccess", true);
        model.addAttribute("updatedFile", finalFilename);
        return "updateByFilename";
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
            String deletedName = note.get().getFilename();
            noteService.deleteNoteById(noteId);

            model.addAttribute("modalSuccess", true);
            model.addAttribute("deletedFile", deletedName);
            return "deleteById";
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
        String finalFilename = normalizeTxtExtension(filename);
        Optional<Note> note = noteService.getNoteByFilenameAndUserId(finalFilename, userId);

        if (note.isPresent()) {
            noteService.deleteNoteById(note.get().getId());
            model.addAttribute("modalSuccess", true);
            model.addAttribute("deletedFile", finalFilename);
            return "deleteByFilename";
        } else {
            model.addAttribute("error", "Note not found or unauthorized.");
            return "deleteByFilename";
        }
    }

    @PostMapping("/note/download/single")
    public void downloadSingleNote(@RequestParam Long noteId,
                                   HttpSession session,
                                   jakarta.servlet.http.HttpServletResponse response
    ) {
        if (session.getAttribute("userId") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        Optional<Note> noteOpt = noteService.getNoteById(noteId);
        if (noteOpt.isEmpty() || !noteOpt.get().getUserId().equals(session.getAttribute("userId"))) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        Note note = noteOpt.get();
        try {
            String filename = note.getFilename();
            if (!filename.endsWith(".txt")) filename += ".txt";

            response.setContentType("text/plain");
            response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");
            response.getOutputStream().write(note.getContent().getBytes());
            response.getOutputStream().flush();
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }


}
