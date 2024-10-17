package com.example.priceComparisonService.services;

import com.example.priceComparisonService.dto.Card;
import com.example.priceComparisonService.dto.Favorite;
import com.example.priceComparisonService.dto.User;
import com.example.priceComparisonService.repositories.FavoritesRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@Slf4j
@RequiredArgsConstructor
public class FavoritesService {
    private final FavoritesRepository favoriteRepository;

    public List<Favorite> getFavoriteCardsByUser(User user) {
        List<Favorite> favorites = favoriteRepository.findByUser(user);
        return favorites;
    }


    public boolean saveFavorite(User user, String name, String marketplace, String url,
                                int price, double rating, int countReviews, String imageUrl) {


        if (favoriteRepository.existsByUserAndCardUrl(user, url)) {
            return false;
        }

        Favorite favorite = new Favorite();
        favorite.setUser(user);
        favorite.setCardName(name);
        favorite.setCardMarketplace(marketplace);
        favorite.setCardUrl(url);
        favorite.setCardPrice(price);
        favorite.setCardRating(rating);
        favorite.setCardCountReviews(countReviews);
        favorite.setCardImageUrl(imageUrl);

        favoriteRepository.save(favorite);
        return true;
    }

    public void updateFavorite(String name, String marketplace, String url,
                               int price, double rating, int countReviews, String imageUrl) {
        Favorite favorite = favoriteRepository.findByCardUrl(url);

        favorite.setCardName(name);
        favorite.setCardMarketplace(marketplace);
        favorite.setCardUrl(url);
        favorite.setCardPrice(price);
        favorite.setCardRating(rating);
        favorite.setCardCountReviews(countReviews);
        favorite.setCardImageUrl(imageUrl);

        favoriteRepository.save(favorite);
    }
}
