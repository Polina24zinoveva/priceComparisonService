package com.example.priceComparisonService.dto;

import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

public class CardContainer {
    private CopyOnWriteArrayList<Card> cards;

    public CardContainer() {
        this.cards = new CopyOnWriteArrayList<>();
    }

    public CopyOnWriteArrayList<Card> getCards() {
        return cards;
    }

    public void addAll(List<Card> newCards) {
        this.cards.addAll(newCards);
    }

    public void add(Card card) {
        this.cards.add(card);
    }
}
