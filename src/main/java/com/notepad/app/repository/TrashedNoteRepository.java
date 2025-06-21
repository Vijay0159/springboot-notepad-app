package com.notepad.app.repository;

import com.notepad.app.entity.TrashedNote;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface TrashedNoteRepository extends JpaRepository<TrashedNote, Long> {
    List<TrashedNote> findByUserId(Long userId);
}
