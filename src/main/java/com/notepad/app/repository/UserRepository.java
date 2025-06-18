package com.notepad.app.repository;

import com.notepad.app.entity.UserData;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

// UserRepository.java
@Repository
public interface UserRepository extends JpaRepository<UserData, Long> {
    Optional<UserData> findByUsername(String username);
}
