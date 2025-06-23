package com.notepad.app.service;

import com.notepad.app.entity.UserData;
import com.notepad.app.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepo;

    @Autowired
    private NoteService noteService;

    public UserData createUser(String username, String password) {
        UserData user = new UserData();
        user.setUsername(username);
        user.setPassword(password); // You may hash this later
        user.setUserType("USER");
        return userRepo.save(user);
    }

    public Optional<UserData> login(String username, String password) {
        return userRepo.findByUsername(username)
                .filter(user -> user.getPassword().equals(password));
    }

    public void deleteAccount(Long userId) {
        // 🧹 Clean up notes and trash before deleting user
        noteService.deleteNotesByUserId(userId);
        noteService.deleteTrashedNotesByUserId(userId);
        userRepo.deleteById(userId);
    }
}
