package com.notepad.app.controller;

import com.notepad.app.entity.UserData;
import com.notepad.app.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@Controller
public class AuthViewController {

    @Autowired
    private UserService userService;

    @GetMapping("/login")
    public String showLoginForm() {
        return "login";
    }

    @PostMapping("/doLogin")
    public String handleLogin(@RequestParam String username,
                              @RequestParam String password,
                              HttpSession session,
                              Model model) {

        if (session.getAttribute("userId") != null) {
            model.addAttribute("message", "Already logged in");
            return "dashboard";
        }

        Optional<UserData> user = userService.login(username, password);
        if (user.isPresent()) {
            session.setAttribute("userId", user.get().getId());
            session.setAttribute("username", user.get().getUsername());
            model.addAttribute("username", user.get().getUsername());
            return "dashboard";
        } else {
            model.addAttribute("error", "Invalid credentials");
            return "login";
        }
    }

    @GetMapping("/register")
    public String showRegisterForm() {
        return "register";
    }

    @PostMapping("/doRegister")
    public String handleRegister(@RequestParam String username,
                                 @RequestParam String password,
                                 Model model) {
        try {
            userService.createUser(username, password);
            model.addAttribute("message", "Registration successful! Please login.");
            return "login";
        } catch (DataIntegrityViolationException e) {
            model.addAttribute("error", "Username already exists. Try another.");
            return "register";
        }
    }


    @GetMapping("/deleteAccount")
    public String showDeleteForm() {
        return "deleteAccount";
    }

    @PostMapping("/doDelete")
    public String handleAccountDelete(HttpSession session, Model model) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            model.addAttribute("error", "You must be logged in to delete account.");
            return "login";
        }

        userService.deleteAccount(userId);
        session.invalidate();
        model.addAttribute("message", "Account deleted successfully.");
        return "logout";
    }

    @GetMapping("/logout")
    public String handleLogout(HttpSession session, Model model) {
        if (session.getAttribute("userId") != null) {
            session.invalidate();
        }
        model.addAttribute("message", "Logged out successfully.");
        return "logout";
    }
}
