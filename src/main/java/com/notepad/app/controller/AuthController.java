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

    @Operation(summary = "Register a new user", description = "Creates a new user with the given username and password.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "User registered successfully"),
            @ApiResponse(responseCode = "400", description = "Invalid input")
    })
    @PostMapping("/register")
    public ResponseEntity<?> register(@RequestBody AuthRequest request) {
        return ResponseEntity.ok(userService.createUser(request.username, request.password));
    }

    @Operation(summary = "Log in user", description = "Authenticates the user and starts a session.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Login successful"),
            @ApiResponse(responseCode = "401", description = "Invalid credentials")
    })
    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody AuthRequest request, HttpSession session) {
        Optional<UserData> user = userService.login(request.username, request.password);
        if (user.isPresent()) {
            session.setAttribute("userId", user.get().getId());
            return ResponseEntity.ok("Login successful");
        }
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid credentials");
    }

    @Operation(summary = "Log out user", description = "Terminates the current session.")
    @PostMapping("/logout")
    public ResponseEntity<?> logout(HttpSession session) {
        session.invalidate();
        return ResponseEntity.ok("Logged out");
    }

    @Operation(summary = "Delete account", description = "Deletes the currently logged-in user's account.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Account deleted"),
            @ApiResponse(responseCode = "401", description = "Unauthorized")
    })
    @DeleteMapping("/account/delete")
    public ResponseEntity<?> deleteAccount(HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        userService.deleteAccount(userId);
        session.invalidate();
        return ResponseEntity.ok("Account deleted");
    }
}
