package com.example.priceComparisonService.controllers;

import com.example.priceComparisonService.dto.Card;
import com.example.priceComparisonService.dto.CardContainer;
import com.example.priceComparisonService.dto.User;
import com.example.priceComparisonService.repositories.FavoritesRepository;
import com.example.priceComparisonService.services.FavoritesService;
import com.example.priceComparisonService.services.SearchService;
import com.example.priceComparisonService.services.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.AllArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.util.*;
import java.util.concurrent.*;
import java.util.stream.Collectors;

@AllArgsConstructor
@Controller
public class ResultSearchPageController {

    private static final Logger log = LoggerFactory.getLogger(ResultSearchPageController.class);
    SearchService searchService = new SearchService();
    UserService userService;
    FavoritesRepository favoritesRepository;


    @PostMapping("/resultsSearch")
    public String resultsSearch(@RequestParam(name = "searchText") String searchText,
                                @RequestParam(name="wbMainPage", required = false, defaultValue = "false") Boolean selectWbMainPage,
                                @RequestParam(name="ozonMainPage", required = false, defaultValue = "false") Boolean selectOzonMainPage,
                                @RequestParam(name="wb", required = false, defaultValue = "false") Boolean selectWb,
                                @RequestParam(name="ozon", required = false, defaultValue = "false") Boolean selectOzon,
                                HttpSession session, Model model, @AuthenticationPrincipal User user) throws IOException {
        // Оборачиваем CopyOnWriteArrayList<Card> в CardContainer
        CardContainer cardContainer = new CardContainer();

        if (!((!selectWbMainPage && !selectOzonMainPage) || (selectWbMainPage && selectOzonMainPage))){
            selectWb = selectWbMainPage;
            selectOzon = selectOzonMainPage;
        }

        if ((selectWb && selectOzon) || (!selectWb && !selectOzon)){
            selectWb = true;
            selectOzon = true;
            ExecutorService executor = Executors.newFixedThreadPool(2); // Создаем пул из двух потоков

            // Создаем задачи для выполнения в параллельных потоках
            Callable<Void> wbTask = () -> {
                searchService.connectToWb(searchText, cardContainer.getCards());
                return null;
            };

            Callable<Void> ozonTask = () -> {
                searchService.connectToOzon(searchText, cardContainer.getCards());
                return null;
            };


            // Отправляем задачи на выполнение
            Future<Void> wbFuture = executor.submit(wbTask);
            Future<Void> ozonFuture = executor.submit(ozonTask);

            try {
                try {
                    // Получение результатов задач
                    wbFuture.get();
                    ozonFuture.get();
                } catch (Exception e) {
                    e.printStackTrace();
                }

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                // Завершение работы пула потоков
                executor.shutdown();
            }
        } else if (selectWb) {
            searchService.connectToWb(searchText, cardContainer.getCards());
        } else if (selectOzon) {
            searchService.connectToOzon(searchText, cardContainer.getCards());
        }

        if (user != null){
            for(Card card : cardContainer.getCards()){
                if (favoritesRepository.existsByUserAndCardUrl(user, card.getUrl())){
                    card.setInFavorites(true);
                }
            }
        }

        session.setAttribute("searchResults", cardContainer.getCards());
        session.setAttribute("searchByDefault", cardContainer.getCards());
        session.setAttribute("selectedRating", 0.0);
        session.setAttribute("selectWb", true);
        session.setAttribute("selectOzon", true);

        session.setAttribute("selectWbMainPage", selectWbMainPage);
        session.setAttribute("selectOzonMainPage", selectOzonMainPage);
        model.addAttribute("searchText", searchText);

        sortByDefault(session, model);

        return "resultsSearch";
    }

//    @PostMapping("/resultsSearch")
//    public String resultsSearch(@RequestParam(name = "searchText") String searchText,
//                                @RequestParam(name="wb", required = false) Boolean selectWb,
//                                @RequestParam(name="ozon", required = false) Boolean selectOzon,
//                                HttpSession session, // Добавляем HttpSession
//                                @AuthenticationPrincipal User user, Model model) throws IOException {
//
//        List<Card> cards = new ArrayList<>();
//        if ((selectWb != null && selectOzon != null) || (selectWb == null && selectOzon == null)){
//            selectWb = true;
//            selectOzon = true;
//            cards.add(new Card("Платье женское вечернее нарядное праздничное повседневное", "Wildberries",
//                    "https://www.wildberries.ru/catalog/162194329/detail.aspx", 1609, 4.6, 40401,
//                    "https://basket-11.wbbasket.ru/vol1621/part162194/162194329/images/c516x688/1.jpg", false));
//
//            cards.add(new Card("Платье женское вечернее нарядное праздничное повседневное", "Ozon",
//                    "https://www.wildberries.ru/catalog/74875398/detail.aspx", 1589, 4.6, 40402,
//                    "https://basket-05.wbbasket.ru/vol748/part74875/74875398/images/c516x688/1.jpg", false));
//
//            cards.add(new Card("Платье", "Ozon",
//                    "https://www.ozon.ru/product/plate-1537134712/?advert=xA4obCFVEZ-XrzEmPETJD4IIbFTsx66GAoihM3kdtlHhq0dfsz7S7jgNIHo2K8p_c1dgmROkmO8eCXKAZmsF1NL5BieBhHgbckkbvkSJpI2ZtK8dg_xYnultHG14S-VrtPmMwMbrNo-26OzrTVNY303ADWXP3zipxNF-OI58VXOFybITzgxRvjLVNoBTY1rXQ0RQMrOMwWqLr-dgBWftwepEs0FuO-Qf0SsqhPbIXfZRgKPYLplSu7HMKOvIaycXXYaQ7fKk-0lW7gCb72VqqiSbnt8gSMfesLI23Ig3U3JL_j8aBbpetqzul23r0myhSegsx0yNcsDMkbitsNhB_GxBiYY5ohHTHMXsJaqfB7U88It3uaNV8bmWNd8E10KgrWspOHCz7OiISFLuysE-L69Q&avtc=1&avte=2&avts=1725636440&keywords=%D0%BF%D0%BB%D0%B0%D1%82%D1%8C%D0%B5",
//                    1525, 4.9, 23,
//                    "https://ir-2.ozone.ru/s3/multimedia-1-k/wc1000/7011786692.jpg", false));
//
//            cards.add(new Card("Платье летнее короткое Сарафан крестьянка", "Wildberries",
//                    "https://www.wildberries.ru/catalog/166706673/detail.aspx", 2015, 4.6, 6335,
//                    "https://basket-12.wbbasket.ru/vol1667/part166706/166706673/images/c516x688/1.jpg", false));
//
//        } else if (selectWb != null) {
//            cards.add(new Card("Платье женское вечернее нарядное праздничное повседневное", "Wildberries",
//                    "https://www.wildberries.ru/catalog/162194329/detail.aspx", 1609, 4.6, 40400,
//                    "https://basket-11.wbbasket.ru/vol1621/part162194/162194329/images/c516x688/1.jpg", false));
//
//            cards.add(new Card("Платье летнее короткое Сарафан крестьянка", "Wildberries",
//                    "https://www.wildberries.ru/catalog/166706673/detail.aspx", 2015, 4.6, 6335,
//                    "https://basket-12.wbbasket.ru/vol1667/part166706/166706673/images/c516x688/1.jpg", false));
//
//        } else if (selectOzon != null) {
//            cards.add(new Card("Платье женское вечернее нарядное праздничное повседневное", "Ozon",
//                    "https://www.wildberries.ru/catalog/74875398/detail.aspx", 1589, 4.6, 40400,
//                    "https://basket-05.wbbasket.ru/vol748/part74875/74875398/images/c516x688/1.jpg", false));
//
//            cards.add(new Card("Платье", "Ozon",
//                    "https://www.ozon.ru/product/plate-1537134712/?advert=xA4obCFVEZ-XrzEmPETJD4IIbFTsx66GAoihM3kdtlHhq0dfsz7S7jgNIHo2K8p_c1dgmROkmO8eCXKAZmsF1NL5BieBhHgbckkbvkSJpI2ZtK8dg_xYnultHG14S-VrtPmMwMbrNo-26OzrTVNY303ADWXP3zipxNF-OI58VXOFybITzgxRvjLVNoBTY1rXQ0RQMrOMwWqLr-dgBWftwepEs0FuO-Qf0SsqhPbIXfZRgKPYLplSu7HMKOvIaycXXYaQ7fKk-0lW7gCb72VqqiSbnt8gSMfesLI23Ig3U3JL_j8aBbpetqzul23r0myhSegsx0yNcsDMkbitsNhB_GxBiYY5ohHTHMXsJaqfB7U88It3uaNV8bmWNd8E10KgrWspOHCz7OiISFLuysE-L69Q&avtc=1&avte=2&avts=1725636440&keywords=%D0%BF%D0%BB%D0%B0%D1%82%D1%8C%D0%B5",
//                    1525, 4.9, 23,
//                    "https://ir-2.ozone.ru/s3/multimedia-1-k/wc1000/7011786692.jpg", false));
//
//        }
//
//        if (user != null){
//            for(Card card : cards){
//                if (favoritesRepository.existsByUserAndCardUrl(user, card.getUrl())){
//                    card.setInFavorites(true);
//                }
//            }
//        }
//
//        session.setAttribute("searchResults", cards);
//        session.setAttribute("selectedRating", 0.0);
//        session.setAttribute("selectWb", selectWb);
//        session.setAttribute("selectOzon", selectOzon);
//        sortByDefault(session, model);
//        return "resultsSearch";
//    }

    @GetMapping("/resultsSearch")
    public String showSearchResults(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        // Получение данных поиска из сессии
        List<Card> cards = (List<Card>) session.getAttribute("searchByDefault");
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

        if (cards != null) {
            saveCardsPriceRatingReviewsSort(session, model, cards,
                    (Double) session.getAttribute("selectedRating"),
                    (String) session.getAttribute("selectedSort"),
                    (Boolean) session.getAttribute("selectWb"),
                    (Boolean) session.getAttribute("selectOzon"),
                    (Boolean) session.getAttribute("selectWbMainPage"),
                    (Boolean) session.getAttribute("selectOzonMainPage"));
        }

        return "resultsSearch";
    }

    @PostMapping("/sortByDefault")
    public String sortByDefault(HttpSession session, Model model){
        // Получение данных поиска из сессии
        List<Card> cards = (List<Card>) session.getAttribute("searchByDefault");

        saveCardsPriceRatingReviewsSort(session, model, cards,
                (Double) session.getAttribute("selectedRating"), "sortByDefault",
                (Boolean) session.getAttribute("selectWb"),
                (Boolean) session.getAttribute("selectOzon"),
                (Boolean) session.getAttribute("selectWbMainPage"),
                (Boolean) session.getAttribute("selectOzonMainPage"));
        log.info("Отсортировано по умолчанию");
        return "resultsSearch";
    }

    @PostMapping("/sortPopular")
    public String sortPopular(HttpSession session, Model model){
        // Получение данных поиска из сессии
        List<Card> cards = (List<Card>) session.getAttribute("searchResults");
        List<Card> sortedCards  = cards.stream()
                .sorted(Comparator.comparingInt(Card::getCountReviews).reversed())
                .collect(Collectors.toList());

        saveCardsPriceRatingReviewsSort(session, model, sortedCards,
                (Double) session.getAttribute("selectedRating"), "sortPopular",
                (Boolean) session.getAttribute("selectWb"),
                (Boolean) session.getAttribute("selectOzon"),
                (Boolean) session.getAttribute("selectWbMainPage"),
                (Boolean) session.getAttribute("selectOzonMainPage"));
        log.info("Отсортировано по популярности");
        return "resultsSearch";
    }

    @PostMapping("/sortRating")
    public String sortRating(HttpSession session, Model model){
        // Получение данных поиска из сессии
        List<Card> cards = (List<Card>) session.getAttribute("searchResults");
        List<Card> sortedCards  = cards.stream()
                .sorted(Comparator.comparingDouble(Card::getRating).reversed())
                .collect(Collectors.toList());

        saveCardsPriceRatingReviewsSort(session, model, sortedCards,
                (Double) session.getAttribute("selectedRating"), "sortRating",
                (Boolean) session.getAttribute("selectWb"),
                (Boolean) session.getAttribute("selectOzon"),
                (Boolean) session.getAttribute("selectWbMainPage"),
                (Boolean) session.getAttribute("selectOzonMainPage"));
        log.info("Отсортировано по рейтингу");
        return "resultsSearch";
    }

    @PostMapping("/sortPriseAsc")
    public String sortPriseAsc(HttpSession session, Model model){
        // Получение данных поиска из сессии
        List<Card> cards = (List<Card>) session.getAttribute("searchResults");
        List<Card> sortedCards  = cards.stream()
                .sorted(Comparator.comparingInt(Card::getPrice))
                .collect(Collectors.toList());

        saveCardsPriceRatingReviewsSort(session, model, sortedCards,
                (Double) session.getAttribute("selectedRating"), "sortPriseAsc",
                (Boolean) session.getAttribute("selectWb"),
                (Boolean) session.getAttribute("selectOzon"),
                (Boolean) session.getAttribute("selectWbMainPage"),
                (Boolean) session.getAttribute("selectOzonMainPage"));
        log.info("Отсортировано по возрастанию цены");
        return "resultsSearch";
    }

    @PostMapping("/sortPriseDesc")
    public String sortPriseDesc(HttpSession session, Model model){
        // Получение данных поиска из сессии
        List<Card> cards = (List<Card>) session.getAttribute("searchResults");

        List<Card> sortedCards  = cards.stream()
                .sorted(Comparator.comparingInt(Card::getPrice).reversed())
                .collect(Collectors.toList());

        saveCardsPriceRatingReviewsSort(session, model, sortedCards,
                (Double) session.getAttribute("selectedRating"), "sortPriseDesc",
                (Boolean) session.getAttribute("selectWb"),
                (Boolean) session.getAttribute("selectOzon"),
                (Boolean) session.getAttribute("selectWbMainPage"),
                (Boolean) session.getAttribute("selectOzonMainPage"));
        log.info("Отсортировано по убыванию цены");
        return "resultsSearch";
    }
    


    @PostMapping("/filters")
    public String filtersSelection(HttpSession session, Model model,
                                   @RequestParam(name="wb", required = false) Boolean selectWb,
                                   @RequestParam(name="ozon", required = false) Boolean selectOzon,
                                   @RequestParam(name = "minPrice", required = false) Integer minPrice,
                                   @RequestParam(name = "maxPrice", required = false) Integer maxPrice,
                                   @RequestParam(name = "rating", required = false) Double rating,
                                   @RequestParam(name = "minReviews", required = false) Integer minReviews,
                                   @RequestParam(name = "maxReviews", required = false) Integer maxReviews) {

        List<Card> cards = (List<Card>) session.getAttribute("searchByDefault");
        String sort = (String) session.getAttribute("selectedSort");

        if (selectWb != null || selectOzon != null){
            if (selectWb == null){
                cards = cards.stream()
                        .filter(b -> !Objects.equals(b.getMarketplace(), "Wildberries"))
                        .collect(Collectors.toCollection(CopyOnWriteArrayList::new));
            }
            if (selectOzon == null){
                cards = cards.stream()
                        .filter(b -> !Objects.equals(b.getMarketplace(), "Ozon"))
                        .collect(Collectors.toCollection(CopyOnWriteArrayList::new));
            }
        }
        else {
            selectWb = true;
            selectOzon = true;
        }

        if (minPrice != null || maxPrice != null){
            int  min = minPrice != null ? minPrice : 0;
            int  max = maxPrice != null ? maxPrice : Integer.MAX_VALUE;

            cards = cards.stream()
                    .filter(b -> b.getPrice() >= min && b.getPrice() <= max)
                    .collect(Collectors.toCollection(CopyOnWriteArrayList::new));
        }

        if (rating != null) {
            double finalMinRating = rating;
            cards = cards.stream()
                    .filter(b -> b.getRating() >= finalMinRating)
                    .collect(Collectors.toCollection(CopyOnWriteArrayList::new));

        }
        else rating = 0.0;


        if (minReviews != null || maxReviews != null){
            int  min = minReviews != null ? minReviews : 0;
            int  max = maxReviews != null ? maxReviews : Integer.MAX_VALUE;

            cards = cards.stream()
                    .filter(b -> b.getCountReviews() >= min && b.getCountReviews() <= max)
                    .collect(Collectors.toCollection(CopyOnWriteArrayList::new));
        }

        List<Card> sortedCards = new ArrayList<>();

        switch (sort){
            case "sortByDefault":
                sortedCards = cards;
                break;
            case "sortPopular":
                sortedCards = cards.stream()
                        .sorted(Comparator.comparingInt(Card::getCountReviews).reversed())
                        .collect(Collectors.toList());
                break;
            case "sortRating":
                sortedCards  = cards.stream()
                        .sorted(Comparator.comparingDouble(Card::getRating).reversed())
                        .collect(Collectors.toList());
                break;
            case "sortPriseAsc":
                sortedCards  = cards.stream()
                        .sorted(Comparator.comparingInt(Card::getPrice))
                        .collect(Collectors.toList());
                break;
            case "sortPriseDesc":
                sortedCards  = cards.stream()
                        .sorted(Comparator.comparingInt(Card::getPrice).reversed())
                        .collect(Collectors.toList());
                break;
            default:
                break;

        }

        Boolean selectWbMainPage = (Boolean) session.getAttribute("selectWbMainPage");
        Boolean selectOzonMainPage = (Boolean) session.getAttribute("selectOzonMainPage");

        saveCardsPriceRatingReviewsSort(session, model, sortedCards, rating,
                (String) session.getAttribute("selectedSort"), selectWb, selectOzon, selectWbMainPage, selectOzonMainPage);

        return "resultsSearch";
    }

    private static void saveCardsPriceRatingReviewsSort(HttpSession session, Model model, List<Card> cards,
                                                        Double rating, String selectedSort, Boolean selectWb,
                                                        Boolean selectOzon, Boolean selectWbMainPage, Boolean selectOzonMainPage) {
        model.addAttribute("cards", cards);
        // Сохранение результатов поиска в сессии
        session.setAttribute("searchResults", cards);

        OptionalInt maxPriceFilteredArray = cards.stream()
                .mapToInt(Card::getPrice)
                .max();
        model.addAttribute("maxPrice", maxPriceFilteredArray.orElse(0));

        OptionalInt minPriceFilteredArray = cards.stream()
                .mapToInt(Card::getPrice)
                .min();
        model.addAttribute("minPrice", minPriceFilteredArray.orElse(0));

        model.addAttribute("selectedRating", rating);
        session.setAttribute("selectedRating", rating);

        OptionalInt maxReviewsFilteredArray = cards.stream()
                .mapToInt(Card::getCountReviews)
                .max();
        model.addAttribute("maxReviews", maxReviewsFilteredArray.orElse(0));

        OptionalInt minReviewsFilteredArray = cards.stream()
                .mapToInt(Card::getCountReviews)
                .min();
        model.addAttribute("minReviews", minReviewsFilteredArray.orElse(0));

        model.addAttribute("selectedSort", selectedSort);
        session.setAttribute("selectedSort", selectedSort);

        model.addAttribute("selectWb", selectWb);
        session.setAttribute("selectWb", selectWb);

        model.addAttribute("selectOzon", selectOzon);
        session.setAttribute("selectOzon", selectOzon);

        model.addAttribute("selectWbMainPage", selectWbMainPage);
        session.setAttribute("selectWbMainPage", selectWbMainPage);

        model.addAttribute("selectOzonMainPage", selectOzonMainPage);
        session.setAttribute("selectOzonMainPage", selectOzonMainPage);
    }

}