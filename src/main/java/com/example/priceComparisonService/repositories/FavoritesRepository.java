package com.example.priceComparisonService.repositories;

import com.example.priceComparisonService.dto.Favorite;
import com.example.priceComparisonService.dto.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface FavoritesRepository extends JpaRepository<Favorite, Long> {
    List<Favorite> findByUser(User user);
    Boolean existsByUserAndCardUrl(User user, String cardUrl);
    Favorite findByCardUrl(String cardUrl);
}
