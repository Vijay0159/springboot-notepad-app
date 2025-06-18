package com.notepad.app.service;

import com.notepad.app.entity.Note;
import com.notepad.app.repository.NoteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class NoteService {

    @Autowired
    private NoteRepository noteRepo;

    public Note createNote(Note note) {
        // Ensure default userType is set
        if (note.getUserType() == null || note.getUserType().isBlank()) {
            note.setUserType("USER");
        }
        return noteRepo.save(note);
    }

    public List<Note> getAllNotesByUser(Long userId) {
        return noteRepo.findByUserId(userId);
    }

    public Optional<Note> getNoteById(Long noteId) {
        return noteRepo.findById(noteId);
    }

    public void deleteNoteById(Long noteId) {
        noteRepo.deleteById(noteId);
    }

    public Note updateNote(Note updatedNote) {
        return noteRepo.save(updatedNote);
    }
}
