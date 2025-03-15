package com.example.priceComparisonService.controllers;

import com.example.priceComparisonService.dto.User;
import com.example.priceComparisonService.repositories.UserRepository;
import com.example.priceComparisonService.services.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequiredArgsConstructor
public class UserController {
    @Autowired
    UserService userService;


    @GetMapping("/login")
    public String login(Model model){
        return "login";
    }

    @PostMapping("/registration")
    public String createUser(User user, RedirectAttributes redirectAttributes){
        if (userService.getUserByEmail(user.getEmail()) != null) {
            redirectAttributes.addFlashAttribute("warning", "На этот email уже зарегистрирован аккаунт");
        }
        else {
            userService.createUser(user);
            redirectAttributes.addFlashAttribute("message", "Вы зарегистрированы");
        }
        return "redirect:/login";
    }

    @GetMapping("/login_not_success")
    public String login_not_success(RedirectAttributes redirectAttributes) {
        redirectAttributes.addFlashAttribute("error", "Не верный email или пароль");
        return "redirect:/login";
    }
}
