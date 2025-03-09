package com.example.priceComparisonService.controllers;

import com.example.priceComparisonService.dto.Card;
import com.example.priceComparisonService.dto.CardContainer;
import com.example.priceComparisonService.dto.User;
import com.example.priceComparisonService.repositories.FavoritesRepository;
import com.example.priceComparisonService.services.SearchService;
import com.example.priceComparisonService.services.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.AllArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.util.*;
import java.util.concurrent.*;
import java.util.concurrent.atomic.AtomicReference;
import java.util.stream.Collectors;

@AllArgsConstructor
@Controller
public class ResultSearchPageController {

    private static final Logger log = LoggerFactory.getLogger(ResultSearchPageController.class);
    SearchService searchService;
    UserService userService;
    FavoritesRepository favoritesRepository;

//
//    @PostMapping("/resultsSearch")
//    public String search(@RequestParam(name = "searchText") String searchText,
//                                @RequestParam(name="wbMainPage", required = false, defaultValue = "false") Boolean selectWbMainPage,
//                                @RequestParam(name="ozonMainPage", required = false, defaultValue = "false") Boolean selectOzonMainPage,
//                                @RequestParam(name="mmMainPage", required = false, defaultValue = "false") Boolean selectMmMainPage,
//                                @RequestParam(name="ymMainPage", required = false, defaultValue = "false") Boolean selectYmMainPage,
//                                @RequestParam(name="wb", required = false, defaultValue = "false") Boolean selectWb,
//                                @RequestParam(name="ozon", required = false, defaultValue = "false") Boolean selectOzon,
//                                @RequestParam(name="mm", required = false, defaultValue = "false") Boolean selectMm,
//                                @RequestParam(name="ym", required = false, defaultValue = "false") Boolean selectYm,
//                                HttpSession session, Model model, @AuthenticationPrincipal User user) throws IOException {
//        // Оборачиваем CopyOnWriteArrayList<Card> в CardContainer
//        CardContainer cardContainer = new CardContainer();
//
//        if (selectWbMainPage == selectOzonMainPage && selectOzonMainPage == selectMmMainPage && selectMmMainPage == selectYmMainPage){
//            selectWbMainPage = selectOzonMainPage = selectMmMainPage = selectYmMainPage = true;
//            selectWb = selectOzon = selectMm = selectYm = true;
//        }
//
//        AtomicReference<String> searchingResultTitle = new AtomicReference<>(searchText);
//
//        // Список задач для выполнения
//        List<Callable<Void>> tasks = new ArrayList<>();
//
//        if (selectWb || selectWbMainPage) {
//            tasks.add(() -> {
//                String result = searchService.connectToWb(searchText, cardContainer.getCards());
//                searchingResultTitle.set(result);
//                return null;
//            });
//        }
//        if (selectOzon || selectOzonMainPage) {
//            tasks.add(() -> {
//                String result = searchService.connectToOzon(searchText, cardContainer.getCards());
//                searchingResultTitle.set(result);
//                return null;
//            });
//        }
//        if (selectMm || selectMmMainPage) {
//            tasks.add(() -> {
//                searchService.connectToMm(searchText, cardContainer.getCards());
//                return null;
//            });
//        }
//        if (selectYm || selectYmMainPage) {
//            tasks.add(() -> {
//                String result = searchService.connectToYm(searchText, cardContainer.getCards());
//                searchingResultTitle.set(result);
//                return null;
//            });
//        }
//
//        // Выполнение задач параллельно
//        ExecutorService executor = Executors.newFixedThreadPool(tasks.size());
//        try {
//            List<Future<Void>> futures = executor.invokeAll(tasks);
//            for (Future<Void> future : futures) {
//                try {
//                    future.get(); // Ожидание выполнения каждой задачи
//                } catch (Exception e) {
//                    e.printStackTrace();
//                }
//            }
//        } catch (InterruptedException e) {
//            e.printStackTrace();
//        } finally {
//            executor.shutdown();
//        }
//
//        // Установка атрибутов в сессии
//        if (user != null) {
//            for (Card card : cardContainer.getCards()) {
//                if (favoritesRepository.existsByUserAndCardUrl(user, card.getUrl())) {
//                    card.setInFavorites(true);
//                }
//            }
//        }
//
//
//        session.setAttribute("searchResults", cardContainer.getCards());
//        session.setAttribute("searchByDefault", cardContainer.getCards());
//        session.setAttribute("selectedRating", 0.0);
//        session.setAttribute("selectWb", true);
//        session.setAttribute("selectOzon", true);
//        session.setAttribute("selectMm", true);
//        session.setAttribute("selectYm", true);
//
//        session.setAttribute("selectWbMainPage", selectWbMainPage);
//        session.setAttribute("selectOzonMainPage", selectOzonMainPage);
//        session.setAttribute("selectMmMainPage", selectMmMainPage);
//        session.setAttribute("selectYmMainPage", selectYmMainPage);
//        session.setAttribute("searchText", searchingResultTitle);
//
//        sortByDefault(session, model);
//
//        return "resultsSearch";
//    }

    @PostMapping("/resultsSearch")
    public String search(@RequestParam(name = "searchText") String searchText,
                         @RequestParam(name="wbMainPage", required = false, defaultValue = "false") Boolean selectWbMainPage,
                         @RequestParam(name="ozonMainPage", required = false, defaultValue = "false") Boolean selectOzonMainPage,
                         @RequestParam(name="mmMainPage", required = false, defaultValue = "false") Boolean selectMmMainPage,
                         @RequestParam(name="ymMainPage", required = false, defaultValue = "false") Boolean selectYmMainPage,
                         @RequestParam(name="wb", required = false, defaultValue = "false") Boolean selectWb,
                         @RequestParam(name="ozon", required = false, defaultValue = "false") Boolean selectOzon,
                         @RequestParam(name="mm", required = false, defaultValue = "false") Boolean selectMm,
                         @RequestParam(name="ym", required = false, defaultValue = "false") Boolean selectYm,
                         HttpSession session,
                         @AuthenticationPrincipal User user, Model model) throws IOException {

        List<Card> cards = new ArrayList<>();
        if ((selectWb != null && selectOzon != null) || (selectWb == null && selectOzon == null)){
            selectWb = true;
            selectOzon = true;
            cards.add(new Card("32 ГБ Флэш-накопитель / USB 3.1 3.0 2.0", "Ozon",
                    "https://www.ozon.ru/product/32-gb-flesh-nakopitel-usb-3-1-3-0-2-0-1414662860/?advert=AAkBjI0o76vfBdS3SSWv7ZL35qwSVC8eIp_YdELg7vEd8nN5TP4rUx1A8bRJpe9y44ICWrN8Ad3JqUjhaIofIyPp8kzQsBimmiWiXOUfojvdAURvwJ27p9W_wHJjMcpea9s5LRMQXnf5JUUnMM3yOK4bc7cUe5DB2mZqct8-sm_nvsCv2TJBI3npyx0hZLHXbymanGPhWY5jqfQuOy3X9muYy2N7VmJ1mhhiekRRFcT2A-Q_Gu0TRPKhFLJKZuByj-HotlhuPqHOkm3UJ5z-hYww3aafBtw3qcVpzy_2HInDU3avYcwaWEDfEgQvt_lUkRxe-imlvwdHW5g8FwmKY_SRRoqrEX5_qsTPJ7CfiIgxvQRXBV7AOIvOh3qJlpJDL7hwmcylU-yKYxRyPH4ejyRi6h70e5pmA_QZMMIYbncKNlw9ojOXlhPWKSff54CJn6Mix2Zudwd06fkuTBCop0FK1z-PXdP7w28&avtc=1&avte=4&avts=1733749688&keywords=%D1%84%D0%BB%D0%B5%D1%88%D0%BA%D0%B0+32+%D0%B3%D0%B1", 274, 4.1, 2935,
                    "https://ir-2.ozone.ru/s3/multimedia-o/wc1000/6580510080.jpg", false));

            cards.add(new Card("Флешка 32 ГБ USB flash накопитель", "Wildberries",
                    "https://www.wildberries.ru/catalog/268491026/detail.aspx", 478, 4.7, 871,
                    "https://basket-17.wbbasket.ru/vol2684/part268491/268491026/images/c246x328/1.webp", false));

            cards.add(new Card("Флешка 32 ГБ USB 3.0 металлическая", "Яндекс Маркет",
                    "https://market.yandex.ru/product--32-gb-fleshka-usb-3-0-flash-nakopitel/73158643?sku=102801123983&uniqueId=57619322&do-waremd5=B2Mlcoq_JBeCZSoVgT3IWw",
                    452, 4.7, 676,
                    "https://avatars.mds.yandex.net/get-mpic/6217624/2a000001924d95d68942960f86b336dcf50c/600x800", false));

            cards.add(new Card("Платье", "Ozon",
                    "https://www.ozon.ru/product/plate-1537134712/?advert=xA4obCFVEZ-XrzEmPETJD4IIbFTsx66GAoihM3kdtlHhq0dfsz7S7jgNIHo2K8p_c1dgmROkmO8eCXKAZmsF1NL5BieBhHgbckkbvkSJpI2ZtK8dg_xYnultHG14S-VrtPmMwMbrNo-26OzrTVNY303ADWXP3zipxNF-OI58VXOFybITzgxRvjLVNoBTY1rXQ0RQMrOMwWqLr-dgBWftwepEs0FuO-Qf0SsqhPbIXfZRgKPYLplSu7HMKOvIaycXXYaQ7fKk-0lW7gCb72VqqiSbnt8gSMfesLI23Ig3U3JL_j8aBbpetqzul23r0myhSegsx0yNcsDMkbitsNhB_GxBiYY5ohHTHMXsJaqfB7U88It3uaNV8bmWNd8E10KgrWspOHCz7OiISFLuysE-L69Q&avtc=1&avte=2&avts=1725636440&keywords=%D0%BF%D0%BB%D0%B0%D1%82%D1%8C%D0%B5",
                    1525, 4.9, 23,
                    "https://ir-2.ozone.ru/s3/multimedia-1-k/wc1000/7011786692.jpg", false));

            cards.add(new Card("Платье летнее короткое Сарафан крестьянка", "Магнит Маркет",
                    "https://www.wildberries.ru/catalog/166706673/detail.aspx", 2015, 4.6, 6335,
                    "https://basket-12.wbbasket.ru/vol1667/part166706/166706673/images/c516x688/1.jpg", false));

        } else if (selectWb != null) {
            cards.add(new Card("Платье женское вечернее нарядное праздничное повседневное", "Wildberries",
                    "https://www.wildberries.ru/catalog/162194329/detail.aspx", 1609, 4.6, 40400,
                    "https://basket-11.wbbasket.ru/vol1621/part162194/162194329/images/c516x688/1.jpg", false));

            cards.add(new Card("Платье летнее короткое Сарафан крестьянка", "Wildberries",
                    "https://www.wildberries.ru/catalog/166706673/detail.aspx", 2015, 4.6, 6335,
                    "https://basket-12.wbbasket.ru/vol1667/part166706/166706673/images/c516x688/1.jpg", false));

        } else if (selectOzon != null) {
            cards.add(new Card("Платье женское вечернее нарядное праздничное повседневное", "Ozon",
                    "https://www.wildberries.ru/catalog/74875398/detail.aspx", 1589, 4.6, 40400,
                    "https://basket-05.wbbasket.ru/vol748/part74875/74875398/images/c516x688/1.jpg", false));

            cards.add(new Card("Платье", "Ozon",
                    "https://www.ozon.ru/product/plate-1537134712/?advert=xA4obCFVEZ-XrzEmPETJD4IIbFTsx66GAoihM3kdtlHhq0dfsz7S7jgNIHo2K8p_c1dgmROkmO8eCXKAZmsF1NL5BieBhHgbckkbvkSJpI2ZtK8dg_xYnultHG14S-VrtPmMwMbrNo-26OzrTVNY303ADWXP3zipxNF-OI58VXOFybITzgxRvjLVNoBTY1rXQ0RQMrOMwWqLr-dgBWftwepEs0FuO-Qf0SsqhPbIXfZRgKPYLplSu7HMKOvIaycXXYaQ7fKk-0lW7gCb72VqqiSbnt8gSMfesLI23Ig3U3JL_j8aBbpetqzul23r0myhSegsx0yNcsDMkbitsNhB_GxBiYY5ohHTHMXsJaqfB7U88It3uaNV8bmWNd8E10KgrWspOHCz7OiISFLuysE-L69Q&avtc=1&avte=2&avts=1725636440&keywords=%D0%BF%D0%BB%D0%B0%D1%82%D1%8C%D0%B5",
                    1525, 4.9, 23,
                    "https://ir-2.ozone.ru/s3/multimedia-1-k/wc1000/7011786692.jpg", false));

        }

        if (user != null){
            for(Card card : cards){
                if (favoritesRepository.existsByUserAndCardUrl(user, card.getUrl())){
                    card.setInFavorites(true);
                }
            }
        }

        session.setAttribute("searchResults", cards);
        session.setAttribute("searchByDefault", cards);
        session.setAttribute("selectedRating", 0.0);
        session.setAttribute("selectWb", true);
        session.setAttribute("selectOzon", true);
        session.setAttribute("selectMm", true);
        session.setAttribute("selectYm", true);

        session.setAttribute("selectWbMainPage", selectWbMainPage);
        session.setAttribute("selectOzonMainPage", selectOzonMainPage);
        session.setAttribute("selectMmMainPage", selectMmMainPage);
        session.setAttribute("selectYmMainPage", selectYmMainPage);
        session.setAttribute("searchText", "Флешка 32гб");


        sortByDefault(session, model);

        return "resultsSearch";
    }

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
                    (Boolean) session.getAttribute("selectMm"),
                    (Boolean) session.getAttribute("selectYm"),
                    (Boolean) session.getAttribute("selectWbMainPage"),
                    (Boolean) session.getAttribute("selectOzonMainPage"),
                    (Boolean) session.getAttribute("selectMmMainPage"),
                    (Boolean) session.getAttribute("selectYmMainPage"));
        }

        return "resultsSearch";
    }

    @PostMapping("/sortByDefault")
    public String sortByDefault(HttpSession session, Model model){
        // Получение данных поиска из сессии
        List<Card> cards = (List<Card>) session.getAttribute("searchByDefault");

        saveCardsPriceRatingReviewsSort(session, model, cards,
                (Double) session.getAttribute("selectedRating"),
                "sortByDefault",
                (Boolean) session.getAttribute("selectWb"),
                (Boolean) session.getAttribute("selectOzon"),
                (Boolean) session.getAttribute("selectMm"),
                (Boolean) session.getAttribute("selectYm"),
                (Boolean) session.getAttribute("selectWbMainPage"),
                (Boolean) session.getAttribute("selectOzonMainPage"),
                (Boolean) session.getAttribute("selectMmMainPage"),
                (Boolean) session.getAttribute("selectYmMainPage"));

        log.info("Отсортировано по умолчанию");
        return "resultsSearch";
    }

    @PostMapping("/sortPopular")
    public String sortByPopular(HttpSession session, Model model){
        // Получение данных поиска из сессии
        List<Card> cards = (List<Card>) session.getAttribute("searchResults");
        List<Card> sortedCards  = cards.stream()
                .sorted(Comparator.comparingInt(Card::getCountReviews).reversed())
                .collect(Collectors.toList());

        saveCardsPriceRatingReviewsSort(session, model, sortedCards,
                (Double) session.getAttribute("selectedRating"), "sortPopular",
                (Boolean) session.getAttribute("selectWb"),
                (Boolean) session.getAttribute("selectOzon"),
                (Boolean) session.getAttribute("selectMm"),
                (Boolean) session.getAttribute("selectYm"),
                (Boolean) session.getAttribute("selectWbMainPage"),
                (Boolean) session.getAttribute("selectOzonMainPage"),
                (Boolean) session.getAttribute("selectMmMainPage"),
                (Boolean) session.getAttribute("selectYmMainPage"));

        log.info("Отсортировано по популярности");
        return "resultsSearch";
    }

    @PostMapping("/sortRating")
    public String sortByRating(HttpSession session, Model model){
        // Получение данных поиска из сессии
        List<Card> cards = (List<Card>) session.getAttribute("searchResults");
        List<Card> sortedCards  = cards.stream()
                .sorted(Comparator.comparingDouble(Card::getRating).reversed())
                .collect(Collectors.toList());


        saveCardsPriceRatingReviewsSort(session, model, sortedCards,
                (Double) session.getAttribute("selectedRating"), "sortRating",
                (Boolean) session.getAttribute("selectWb"),
                (Boolean) session.getAttribute("selectOzon"),
                (Boolean) session.getAttribute("selectMm"),
                (Boolean) session.getAttribute("selectYm"),
                (Boolean) session.getAttribute("selectWbMainPage"),
                (Boolean) session.getAttribute("selectOzonMainPage"),
                (Boolean) session.getAttribute("selectMmMainPage"),
                (Boolean) session.getAttribute("selectYmMainPage"));

        log.info("Отсортировано по рейтингу");
        return "resultsSearch";
    }

    @PostMapping("/sortPriseAsc")
    public String sortByPriseAsc(HttpSession session, Model model){
        // Получение данных поиска из сессии
        List<Card> cards = (List<Card>) session.getAttribute("searchResults");
        List<Card> sortedCards  = cards.stream()
                .sorted(Comparator.comparingInt(Card::getPrice))
                .collect(Collectors.toList());

        saveCardsPriceRatingReviewsSort(session, model, sortedCards,
                (Double) session.getAttribute("selectedRating"), "sortPriseAsc",
                (Boolean) session.getAttribute("selectWb"),
                (Boolean) session.getAttribute("selectOzon"),
                (Boolean) session.getAttribute("selectMm"),
                (Boolean) session.getAttribute("selectYm"),
                (Boolean) session.getAttribute("selectWbMainPage"),
                (Boolean) session.getAttribute("selectOzonMainPage"),
                (Boolean) session.getAttribute("selectMmMainPage"),
                (Boolean) session.getAttribute("selectYmMainPage"));
        log.info("Отсортировано по возрастанию цены");
        return "resultsSearch";
    }

    @PostMapping("/sortPriseDesc")
    public String sortBePriseDesc(HttpSession session, Model model){
        // Получение данных поиска из сессии
        List<Card> cards = (List<Card>) session.getAttribute("searchResults");

        List<Card> sortedCards  = cards.stream()
                .sorted(Comparator.comparingInt(Card::getPrice).reversed())
                .collect(Collectors.toList());

        saveCardsPriceRatingReviewsSort(session, model, sortedCards,
                (Double) session.getAttribute("selectedRating"), "sortPriseDesc",
                (Boolean) session.getAttribute("selectWb"),
                (Boolean) session.getAttribute("selectOzon"),
                (Boolean) session.getAttribute("selectMm"),
                (Boolean) session.getAttribute("selectYm"),
                (Boolean) session.getAttribute("selectWbMainPage"),
                (Boolean) session.getAttribute("selectOzonMainPage"),
                (Boolean) session.getAttribute("selectMmMainPage"),
                (Boolean) session.getAttribute("selectYmMainPage"));
        log.info("Отсортировано по убыванию цены");
        return "resultsSearch";
    }
    


    @PostMapping("/filters")
    public String filtersSelection(HttpSession session, Model model,
                                   @RequestParam(name="wb", required = false, defaultValue = "false") Boolean selectWb,
                                   @RequestParam(name="ozon", required = false, defaultValue = "false") Boolean selectOzon,
                                   @RequestParam(name="mm", required = false, defaultValue = "false") Boolean selectMm,
                                   @RequestParam(name="ym", required = false, defaultValue = "false") Boolean selectYm,
                                   @RequestParam(name = "minPrice", required = false) Integer minPrice,
                                   @RequestParam(name = "maxPrice", required = false) Integer maxPrice,
                                   @RequestParam(name = "rating", required = false) Double rating,
                                   @RequestParam(name = "minReviews", required = false) Integer minReviews,
                                   @RequestParam(name = "maxReviews", required = false) Integer maxReviews) {

        List<Card> cards = (List<Card>) session.getAttribute("searchByDefault");
        String sort = (String) session.getAttribute("selectedSort");

        int[] a = new int[10];
        System.out.println(a.length);
        if (selectWb || selectOzon || selectMm || selectYm){
            if (!selectWb){
                cards = cards.stream()
                        .filter(b -> !Objects.equals(b.getMarketplace(), "Wildberries"))
                        .collect(Collectors.toCollection(CopyOnWriteArrayList::new));
            }
            if (!selectOzon){
                cards = cards.stream()
                        .filter(b -> !Objects.equals(b.getMarketplace(), "Ozon"))
                        .collect(Collectors.toCollection(CopyOnWriteArrayList::new));
            }
            if (!selectMm){
                cards = cards.stream()
                        .filter(b -> !Objects.equals(b.getMarketplace(), "Магнит Маркет"))
                        .collect(Collectors.toCollection(CopyOnWriteArrayList::new));
            }
            if (!selectYm){
                cards = cards.stream()
                        .filter(b -> !Objects.equals(b.getMarketplace(), "Яндекс Маркет"))
                        .collect(Collectors.toCollection(CopyOnWriteArrayList::new));
            }
        }
        else {
            selectWb = true;
            selectOzon = true;
            selectMm = true;
            selectYm = true;
        }

        if (minPrice != null || maxPrice != null){
            int  min = minPrice != null ? minPrice : (Integer) session.getAttribute("minPrice");
            int  max = maxPrice != null ? maxPrice : (Integer) session.getAttribute("maxPrice");

            cards = cards.stream()
                    .filter(b -> b.getPrice() >= min && b.getPrice() <= max)
                    .collect(Collectors.toCollection(CopyOnWriteArrayList::new));
        }
        else {
            int  min = (Integer) session.getAttribute("minPrice");
            int  max = (Integer) session.getAttribute("maxPrice");

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
            int  min = minReviews != null ? minReviews : (Integer) session.getAttribute("minReviews");
            int  max = maxReviews != null ? maxReviews : (Integer) session.getAttribute("maxReviews");

            cards = cards.stream()
                    .filter(b -> b.getCountReviews() >= min && b.getCountReviews() <= max)
                    .collect(Collectors.toCollection(CopyOnWriteArrayList::new));
        }
        else{
            int  min = (Integer) session.getAttribute("minReviews");
            int  max = (Integer) session.getAttribute("maxReviews");

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
        Boolean selectMmMainPage = (Boolean) session.getAttribute("selectMmMainPage");
        Boolean selectYmMainPage = (Boolean) session.getAttribute("selectYmMainPage");

        saveCardsPriceRatingReviewsSort(session, model, sortedCards, rating,
                (String) session.getAttribute("selectedSort"), selectWb, selectOzon, selectMm, selectYm,
                selectWbMainPage, selectOzonMainPage, selectMmMainPage, selectYmMainPage);

        return "resultsSearch";
    }

    private static void saveCardsPriceRatingReviewsSort(HttpSession session, Model model, List<Card> cards,
                                                        Double rating, String selectedSort, Boolean selectWb,
                                                        Boolean selectOzon, Boolean selectMm, Boolean selectYm,
                                                        Boolean selectWbMainPage, Boolean selectOzonMainPage,
                                                        Boolean selectMmMainPage, Boolean selectYmMainPage) {
        model.addAttribute("cards", cards);
        // Сохранение результатов поиска в сессии
        session.setAttribute("searchResults", cards);

        model.addAttribute("selectedRating", rating);
        session.setAttribute("selectedRating", rating);

        OptionalInt maxPriceFilteredArray = cards.stream()
                .mapToInt(Card::getPrice)
                .max();
        model.addAttribute("maxPrice", maxPriceFilteredArray.orElse(0));
        OptionalInt minPriceFilteredArray = cards.stream()
                .mapToInt(Card::getPrice)
                .min();
        model.addAttribute("minPrice", minPriceFilteredArray.orElse(0));

        model.addAttribute("selectedSort", selectedSort);
        session.setAttribute("selectedSort", selectedSort);

        OptionalInt maxReviewsFilteredArray = cards.stream()
                .mapToInt(Card::getCountReviews)
                .max();
        model.addAttribute("maxReviews", maxReviewsFilteredArray.orElse(0));
        OptionalInt minReviewsFilteredArray = cards.stream()
                .mapToInt(Card::getCountReviews)
                .min();
        model.addAttribute("minReviews", minReviewsFilteredArray.orElse(0));

        if (!cards.isEmpty()){

            session.setAttribute("maxPrice", maxPriceFilteredArray.orElse(0));
            session.setAttribute("minPrice", minPriceFilteredArray.orElse(0));
            session.setAttribute("maxReviews", maxReviewsFilteredArray.orElse(0));
            session.setAttribute("minReviews", minReviewsFilteredArray.orElse(0));
        }

        model.addAttribute("selectWb", selectWb);
        session.setAttribute("selectWb", selectWb);

        model.addAttribute("selectOzon", selectOzon);
        session.setAttribute("selectOzon", selectOzon);

        model.addAttribute("selectMm", selectMm);
        session.setAttribute("selectMm", selectMm);

        model.addAttribute("selectYm", selectYm);
        session.setAttribute("selectYm", selectYm);


        model.addAttribute("selectWbMainPage", selectWbMainPage);
        session.setAttribute("selectWbMainPage", selectWbMainPage);

        model.addAttribute("selectOzonMainPage", selectOzonMainPage);
        session.setAttribute("selectOzonMainPage", selectOzonMainPage);

        model.addAttribute("selectMmMainPage", selectMmMainPage);
        session.setAttribute("selectMmMainPage", selectMmMainPage);

        model.addAttribute("selectYmMainPage", selectYmMainPage);
        session.setAttribute("selectYmMainPage", selectYmMainPage);

        model.addAttribute("searchText", session.getAttribute("searchText"));
    }

}
