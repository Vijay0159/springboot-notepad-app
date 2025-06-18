package com.notepad.app.controller;

import com.notepad.app.entity.UserData;
import com.notepad.app.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private UserService userService;

    static class AuthRequest {
        public String username;
        public String password;
    }

    @PostMapping("/register")
    public ResponseEntity<?> register(@RequestBody AuthRequest request) {
        return ResponseEntity.ok(userService.createUser(request.username, request.password));
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody AuthRequest request, HttpSession session) {
        if (session.getAttribute("userId") != null) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Already logged in. Logout first to login again.");
        }

        Optional<UserData> user = userService.login(request.username, request.password);
        if (user.isPresent()) {
            session.setAttribute("userId", user.get().getId());
            session.setAttribute("username", user.get().getUsername());
            return ResponseEntity.ok("Successfully logged in as " + user.get().getUsername());
        }
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid credentials");
    }

    @PostMapping("/logout")
    public ResponseEntity<?> logout(HttpSession session) {
        if (session.getAttribute("userId") == null) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("You are already logged out.");
        }
        session.invalidate();
        return ResponseEntity.ok("Successfully logged out");
    }

    @DeleteMapping("/account/delete")
    public ResponseEntity<?> deleteAccount(HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Login before attempting to delete account.");
        }
        userService.deleteAccount(userId);
        session.invalidate();
        return ResponseEntity.ok("Account deleted and logged out");
    }
}
