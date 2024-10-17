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

@Controller
@RequiredArgsConstructor
public class UserController {
    @Autowired
    UserService userService;

    private String message = null;
    private String warning = null;
    private String error = null;


//    @GetMapping("/registration")
//    public String registration(Model model){
////        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
////        String username = authentication.getName();
////        User user = userService.getUserByEmail(username);
////        model.addAttribute("isAdmin", user != null && user.getIsAdministrator());
//        return "registration";
//    }


    @GetMapping("/login")
    public String login(Model model){
        if (message != null) model.addAttribute("message", message);
        if (warning != null) model.addAttribute("warning", warning);
        if (error != null) model.addAttribute("error", error);
        message = null;
        warning = null;
        error = null;
        return "login";
    }

    @PostMapping("/registration")
    public String createUser(User user){
        if (userService.getUserByEmail(user.getEmail()) != null) {
            warning = "На этот email уже зарегистрирован аккаунт";
        }
        else {
//            message = "На вашу электронную почту отправлен код для активации аккаунта";
//            if (!userService.createUser(userWithoutLink)) {
//                return "redirect:/login?error";
//            }
            userService.createUser(user);
            message = "Вы зарегистрированы";
        }
        return "redirect:/login";
    }

    @GetMapping("/login_not_success")
    public String login_not_success() {
        error = "Не верный email или пароль";
        return "redirect:/login";
    }
}
