package com.notepad.app.service;

import com.notepad.app.entity.Note;
import com.notepad.app.entity.TrashedNote;
import com.notepad.app.repository.NoteRepository;
import com.notepad.app.repository.TrashedNoteRepository;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class NoteService {

    @Autowired
    private NoteRepository noteRepo;

    @Autowired
    private TrashedNoteRepository trashRepo;

    @PersistenceContext
    private EntityManager entityManager;

    @Transactional
    public Note createNote(Note note) {
        if (note.getUserType() == null || note.getUserType().isBlank()) {
            note.setUserType("USER");
        }

        Note saved = noteRepo.save(note);
        entityManager.flush();
        entityManager.refresh(saved);
        return saved;
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

    public Optional<Note> getNoteByFilenameAndUserId(String filename, Long userId) {
        return noteRepo.findByFilenameAndUserId(filename, userId);
    }

    @Transactional
    public Note updateNote(Note updatedNote) {
        Note saved = noteRepo.save(updatedNote);
        entityManager.flush();
        entityManager.refresh(saved);
        return saved;
    }

    public boolean isDuplicateFilenameForUserExceptId(String filename, Long userId, Long excludeNoteId) {
        Optional<Note> existing = noteRepo.findByFilenameAndUserId(filename, userId);
        return existing.isPresent() && !existing.get().getId().equals(excludeNoteId);
    }

    @Transactional
    public void moveNoteToTrash(Note note) {
        TrashedNote trash = new TrashedNote();
        trash.setOriginalNoteId(note.getId());
        trash.setUserId(note.getUserId());
        trash.setFilename(note.getFilename());
        trash.setContent(note.getContent());

        trashRepo.save(trash);
        noteRepo.deleteById(note.getId());
    }

    public List<TrashedNote> getTrashedNotesByUser(Long userId) {
        return trashRepo.findByUserId(userId);
    }

    @Transactional
    public Optional<Note> restoreNoteFromTrash(Long trashId) {
        Optional<TrashedNote> trashedOpt = trashRepo.findById(trashId);
        if (trashedOpt.isEmpty()) return Optional.empty();

        TrashedNote trashed = trashedOpt.get();

        Note restored = new Note();
        restored.setUserId(trashed.getUserId());
        restored.setFilename(trashed.getFilename());
        restored.setContent(trashed.getContent());
        restored.setUserType("USER");

        Note saved = noteRepo.save(restored);
        trashRepo.deleteById(trashId);

        return Optional.of(saved);
    }

    @Transactional
    public boolean deleteNoteFromTrashPermanently(Long trashId) {
        Optional<TrashedNote> trashedNoteOpt = trashRepo.findById(trashId);
        if (trashedNoteOpt.isPresent()) {
            trashRepo.deleteById(trashId);
            return true;
        }
        return false;
    }

}
