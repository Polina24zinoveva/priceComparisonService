package com.example.priceComparisonService.dto;

import jakarta.persistence.*;
import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Entity
public class Favorite {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    // Сохранение минимальной информации о Card
    @Column
    private String cardName;

    @Column
    private String cardMarketplace;

    @Column
    private int cardPrice;

    @Column
    private double cardRating;

    @Column
    private int cardCountReviews;

    @Column(length = 2048)
    private String cardUrl;

    @Column
    private String cardImageUrl;

}
