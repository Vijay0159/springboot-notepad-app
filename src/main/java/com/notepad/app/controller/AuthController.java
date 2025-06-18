package com.notepad.app.controller;

import com.notepad.app.entity.UserData;
import com.notepad.app.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

// AuthController.java
@RestController
@RequestMapping("/auth")
public class AuthController {
    @Autowired
    private UserService userService;

    @PostMapping("/register")
    public ResponseEntity<?> register(@RequestParam String username, @RequestParam String password) {
        return ResponseEntity.ok(userService.createUser(username, password));
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(HttpSession session, @RequestParam String username, @RequestParam String password) {
        Optional<UserData> user = userService.login(username, password);
        if (user.isPresent()) {
            session.setAttribute("userId", user.get().getId());
            return ResponseEntity.ok("Login successful");
        }
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid credentials");
    }

    @PostMapping("/logout")
    public ResponseEntity<?> logout(HttpSession session) {
        session.invalidate();
        return ResponseEntity.ok("Logged out");
    }

    @DeleteMapping("/delete")
    public ResponseEntity<?> deleteAccount(HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        userService.deleteAccount(userId);
        session.invalidate();
        return ResponseEntity.ok("Account deleted");
    }
}
