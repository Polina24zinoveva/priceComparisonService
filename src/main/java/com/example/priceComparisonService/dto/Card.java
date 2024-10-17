package com.example.priceComparisonService.dto;

import lombok.*;

import javax.management.ConstructorParameters;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class Card {
    private String name;
    private String marketplace;
    private String url;
    private int price;
    private double rating;
    private int countReviews;
    private String imageUrl;
    private Boolean inFavorites;
}
