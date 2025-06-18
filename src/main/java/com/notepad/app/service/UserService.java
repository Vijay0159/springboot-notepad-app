package com.notepad.app.service;

import com.notepad.app.entity.UserData;
import com.notepad.app.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

// UserService.java
@Service
public class UserService {
    @Autowired
    private UserRepository userRepo;

    public UserData createUser(String username, String password) {
        UserData user = new UserData();
        user.setUsername(username);
        user.setPassword(password); // later you can hash it
        user.setUserType("USER");
        return userRepo.save(user);
    }

    public Optional<UserData> login(String username, String password) {
        return userRepo.findByUsername(username)
                .filter(user -> user.getPassword().equals(password));
    }

    public void deleteAccount(Long userId) {
        userRepo.deleteById(userId);
    }
}
