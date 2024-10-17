package com.example.priceComparisonService.services;

import com.example.priceComparisonService.dto.User;
import com.example.priceComparisonService.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@Slf4j
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public boolean createUser(User user){
        if (userRepository.findByEmail(user.getEmail()) != null) {
            return false;
        }
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        log.info("Создан новый пользователь с email {}", user.getEmail());
        userRepository.save(user);
        return true;
    }

    public User getUserByEmail(String userEmail)
    {
        return userRepository.findByEmail(userEmail);
    }


}
