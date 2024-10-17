package com.example.priceComparisonService.repositories;

import com.example.priceComparisonService.dto.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, String> {
    User findByEmail(String email);
}
