package com.example.priceComparisonService.controllers;

import com.example.priceComparisonService.dto.Card;
import com.example.priceComparisonService.dto.Favorite;
import com.example.priceComparisonService.dto.User;
import com.example.priceComparisonService.repositories.FavoritesRepository;
import com.example.priceComparisonService.services.FavoritesService;
import com.example.priceComparisonService.services.SearchService;
import com.example.priceComparisonService.services.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

@Controller
@RequiredArgsConstructor
public class FavoritesController {

    private static final Logger log = LoggerFactory.getLogger(FavoritesController.class);
    private final FavoritesService favoriteService;
    private final SearchService searchService;
    private final FavoritesRepository favoritesRepository;

    private final UserService userService;

    @GetMapping("favorites")
    public String favoritesPage(HttpSession session, @AuthenticationPrincipal User user, Model model) {
        List<Favorite> favoritesList = favoritesRepository.findByUser(user);
        model.addAttribute("cards", favoritesList);
        if(session.getAttribute("idFavorite") == null) session.setAttribute("idFavorite", -1);
        model.addAttribute("idFavorite", session.getAttribute("idFavorite"));
        // Сохранение результатов поиска в сессии
        session.setAttribute("searchResultsFavorites", favoritesList);

        // Получение данных из сессии
        String warning = (String) session.getAttribute("warning");
        String message = (String) session.getAttribute("message");
        if (warning != null) {
            model.addAttribute("warning", warning);
            session.removeAttribute("warning");
        }
        if (message != null) {
            model.addAttribute("message", message);
            session.removeAttribute("message");
        }
        return "favorites";
    }


    @PostMapping("/checkPrice")
    //@PreAuthorize("isAuthenticated()")
    public String checkPrice(HttpSession session,
                             @RequestParam(name = "marketplace") String marketplace,
                             @RequestParam(name = "url") String url,
                             @RequestParam(name = "idFavorite") Long idFavorite,
                             RedirectAttributes redirectAttributes) throws IOException {
        Card checkedCard = new Card();
        Favorite checkedFavorite = new Favorite();
        try {
            switch (marketplace)
            {
                case "Wildberries":
                    checkedCard = searchService.checkPriceWb(url);
                    break;
                case "Ozon":
                    checkedCard = searchService.checkPriceOzon(url);
                    break;
                case "Магнит Маркет":
                    checkedCard = searchService.checkPriceMm(url);
                    break;
                case "Яндекс Маркет":
                    checkedCard = searchService.checkPriceYM(url);
                    break;
            }

            if (checkedCard == null){
                redirectAttributes.addFlashAttribute("warningCheck", "Произошла ошибка. Возможно товар закончился или был удален");
                checkedFavorite = favoritesRepository.findById(idFavorite).orElse(null);
                session.setAttribute("idFavorite", checkedFavorite != null? checkedFavorite.getId(): -1);
            }
            else {
                redirectAttributes.addFlashAttribute("message", "Цена обновлена");
                session.setAttribute("idFavorite", -1);
            }

            ArrayList<Favorite> cards = (ArrayList<Favorite>) session.getAttribute("searchResultsFavorites");

            if (cards != null && checkedCard != null) {
                checkedFavorite = favoritesRepository.findById(idFavorite).orElse(null);
                checkedFavorite.setCardPrice(checkedCard.getPrice());
                checkedFavorite.setCardRating(checkedCard.getRating());
                checkedFavorite.setCardCountReviews(checkedCard.getCountReviews());
                checkedFavorite.setCardName(checkedCard.getName());

                // Найти карточку по URL
                Optional<Favorite> optionalCard = cards.stream()
                        .filter(card -> card.getCardUrl().equals(url))
                        .findFirst();

                cards.set(cards.indexOf(optionalCard.get()), checkedFavorite);

                favoriteService.updateFavorite(checkedFavorite.getCardName(), checkedFavorite.getCardMarketplace(),
                        checkedFavorite.getCardUrl(), checkedFavorite.getCardPrice(), checkedFavorite.getCardRating(),
                        checkedFavorite.getCardCountReviews(), checkedFavorite.getCardImageUrl());
                log.info("Внесены изменения в БД");
            }
            redirectAttributes.addFlashAttribute("cards", cards);
            session.setAttribute("searchResultsFavorites", cards);

        } catch (Exception e){
            e.printStackTrace();
        }
        return "redirect:/favorites";
    }

    @PostMapping("/deleteFavorite")
    @PreAuthorize("isAuthenticated()")
    public String deleteFavorite(HttpSession session, @AuthenticationPrincipal User user,
                                @RequestParam(name = "idFavorite") Long idFavorite, Model model){
        try {
            favoritesRepository.deleteById(idFavorite);
            log.info("Message: Успешно удалено из избранного");

            ArrayList<Favorite> favorites = (ArrayList<Favorite>) favoritesRepository.findByUser(user);

            model.addAttribute("cards", favorites);
            session.setAttribute("searchResultsFavorites", favorites);
            session.setAttribute("message", "Товар успешно удален из избранного");

        }
        catch (Exception e){
            session.setAttribute("warning", "Произошла ошибка. Не удалось удалить товар");
        }
        if ((session.getAttribute("idFavorite") == null) || (session.getAttribute("idFavorite")).equals(-1)) return "redirect:/favorites";
        else {
            session.setAttribute("idFavorite", -1);
            return "favorites";
        }
    }


    @PostMapping("/removeFromFavoritesInResultSearchPage")
    @PreAuthorize("isAuthenticated()")
    public String removeFromFavoritesWithoutUser(HttpSession session, @AuthenticationPrincipal User user,
                                                 @RequestParam(name = "url") String url, Model model){

        try {
            Favorite favorite = favoritesRepository.findByCardUrl(url);
            if (favorite != null){
                favoritesRepository.deleteById(favorite.getId());
                session.setAttribute("message", "Успешно удалено из избранного");
                log.info("Message: Успешно удалено из избранного");
            }
            else{
                log.info("Товар не удален из избранного");
            }

            // Получение данных поиска из сессии
            List<Card> cards = (List<Card>) session.getAttribute("searchResults");

            if (user != null){
                for(Card card : cards){
                    if (favoritesRepository.existsByUserAndCardUrl(user, card.getUrl())){
                        card.setInFavorites(true);
                    }
                    else card.setInFavorites(false);
                }
            }
            model.addAttribute("cards", cards);
            session.setAttribute("searchResultsFavorites", cards);

        }
        catch (Exception e){
            model.addAttribute("warning", "Произошла ошибка. Не удалось удалить товар");
        }
        return "redirect:/resultsSearch";
    }

    @PostMapping("/addToFavorite")
    @PreAuthorize("isAuthenticated()")
    public String addToFavorite(HttpSession session, @AuthenticationPrincipal User user, RedirectAttributes redirectAttributes,
                            @RequestParam(name = "name") String name,
                            @RequestParam(name = "marketplace") String marketplace,
                            @RequestParam(name = "url") String url,
                            @RequestParam(name = "price") String priceText,
                            @RequestParam(name = "rating") Double rating,
                            @RequestParam(name = "countReviews") String countReviewsText,
                            @RequestParam(name = "imageUrl") String imageUrl,
                            @RequestParam(name = "searchText") String searchText,
                            Model model) {

        List<Favorite> favoritesList = favoritesRepository.findByUser(user);
        boolean favBouquetExists = favoritesList.stream()
                .anyMatch(favoriteB -> Objects.equals(favoriteB.getCardUrl(), url));

        if (favBouquetExists) {
            session.setAttribute("warning", "Товар уже в избранном");
            log.info("Warning: Товар уже в избранном");
        } else {
            int price = Integer.parseInt(priceText.replaceAll("\\p{Zs}",""));
            int countReviews = Integer.parseInt(countReviewsText.replaceAll("\\p{Zs}",""));
            favoriteService.saveFavorite(user, name, marketplace, url, price, rating, countReviews, imageUrl, searchText);

            session.setAttribute("message", "Успешно добавлено в избранное");
            log.info("Message: Успешно добавлено в избранное");
        }

        // Получение данных поиска из сессии
        List<Card> cards = (List<Card>) session.getAttribute("searchResults");
        if (user != null){
            for(Card card : cards){
                if (favoritesRepository.existsByUserAndCardUrl(user, card.getUrl())){
                    card.setInFavorites(true);
                }
                else card.setInFavorites(false);
            }
        }
        model.addAttribute("cards", cards);
        session.setAttribute("cards", cards);
        return "redirect:/resultsSearch";
    }
}
