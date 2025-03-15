package com.example.priceComparisonService.services;

import com.example.priceComparisonService.dto.Card;
import lombok.extern.slf4j.Slf4j;
import org.openqa.selenium.*;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;


@Service
@Slf4j
public class SearchService {

    public String connectToWb(String productName, CopyOnWriteArrayList<Card> cards) {
        WebDriver driver = connectToWebDriver();
        try {
            // Открытие сайта Wildberries
            connectToUrl("https://www.wildberries.ru/", driver);

            // Инициализация WebDriverWait
            WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(5));

            // Ожидание, пока поле поиска станет доступным
            WebElement searchBox = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("searchInput")));
            searchBox.sendKeys(productName);

            // Ожидание, пока кнопка поиска станет кликабельной
            WebElement searchButton = wait.until(ExpectedConditions.elementToBeClickable(By.cssSelector(".search-catalog__btn--search")));
            ((JavascriptExecutor) driver).executeScript("arguments[0].click();", searchButton);

            // Ожидание загрузки результатов
            wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector(".product-card")));

            // Повторное получение элементов
            List<WebElement> productItems = driver.findElements(By.cssSelector(".product-card"));

            String searchingResultTitle;
            try {
                searchingResultTitle = driver.findElement(By.className("searching-results__title")).getText();
                searchingResultTitle = searchingResultTitle.substring(0, 1).toUpperCase() + searchingResultTitle.substring(1);
            }
            catch (Exception e){
                searchingResultTitle = productName;
            }

            // Обработка каждого товара
            for (WebElement item : productItems) {
                // Название
                String name = item.findElement(By.cssSelector(".product-card__name"))
                        .getText()
                        .replace("/ ", "");

                // Цена
                String priceText = item.findElement(By.cssSelector(".price__lower-price"))
                        .getText()
                        .replaceAll("[^\\d]", "");
                int price = priceText.isEmpty() ? 0 : Integer.parseInt(priceText);

                // Ссылка на товар
                String url = item.findElement(By.cssSelector("a")).getAttribute("href");

                // Рейтинг
                String ratingText = item.findElement(By.cssSelector(".address-rate-mini"))
                        .getText()
                        .replace(",", ".");
                double rating = ratingText.isEmpty() ? 0 : Double.parseDouble(ratingText);

                // Количество заказов
                String countReviewsText = item.findElement(By.cssSelector(".product-card__count"))
                        .getText()
                        .replaceAll("[^\\d]", "");
                int countReviews = countReviewsText.isEmpty() ? 0 : Integer.parseInt(countReviewsText);

                // Фото
                String imageUrl = item.findElement(By.cssSelector(".product-card__img-wrap img")).getAttribute("src");

                Card card = new Card(name, "Wildberries", url, price, rating, countReviews, imageUrl, false);
                cards.add(card);
            }
            log.info("Результат поиска на Wildberries готов");
            return searchingResultTitle;

        } catch (Exception e) {
            e.printStackTrace();
            log.info("Ошибка в Wildberries");
            return productName;
        } finally {
            driver.quit();
        }
    }

    public String connectToOzon(String productName, CopyOnWriteArrayList<Card> cards) {
        WebDriver driver = connectToWebDriver();
        try {
            connectToUrl("https://www.ozon.ru/", driver);

            // Инициализация WebDriverWait
            WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(5));

            // Ожидание, пока поле поиска станет доступным
            WebElement searchBox = wait.until(ExpectedConditions.visibilityOfElementLocated(By.name("text")));
            searchBox.sendKeys(productName);

            // Отправка формы поиска
            searchBox.submit();

            List<WebElement> productItems = null;
            try {
                // Ожидание загрузки результатов
                wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector(".tile-root")));
                productItems = driver.findElements(By.cssSelector(".tile-root"));
            }
            catch (Exception e){
                log.info("Ошибка в загрузке карточек товаров");
            }

            String searchingResultTitle;
            try {
                searchingResultTitle = driver.findElement(By.xpath("//*[@id=\"layoutPage\"]/div[1]/div[2]/div[1]/div/div[1]/div[1]/strong"))
                        .getText();
                searchingResultTitle = searchingResultTitle.substring(0, 1).toUpperCase() + searchingResultTitle.substring(1);
            }
            catch (Exception e){
                searchingResultTitle = productName;
            }

            // Обработка каждого товара
            for (WebElement item : productItems) {
                // Название
                String name = item.findElement(By.cssSelector(".tsBody500Medium"))
                        .getText()
                        .replace("/ ", "");

                // Цена
                int price = 0;
                try {
                    String priceText = item.findElement(By.cssSelector(".tsHeadline500Medium"))
                            .getText()
                            .replaceAll("[^\\d]", "");
                    price = priceText.isEmpty() ? 0 : Integer.parseInt(priceText);
                }
                catch (Exception e){
                    log.info("У товара в Ozon нет цены");
                    continue;
                }


                // Ссылка на товар
                String url = item.findElement(By.cssSelector("a")).getAttribute("href");


                double rating = 0;
                int countReviews = 0;
                try {
                    // Рейтинг
                    String ratingText = item.findElements(By.xpath(".//span[contains(text(), '.')]")).getLast().getText().replaceAll(" ", "");
                    rating = ratingText.isEmpty() ? 0 : Double.parseDouble(ratingText);

                    // Количество заказов
                    String countReviewsText = item.findElement(By.xpath(".//span[contains(text(), 'отзыв')]"))
                            .getText()
                            .split(" ")[0]
                            .replaceAll("[^\\d]", "");
                    countReviews = countReviewsText.isEmpty() ? 0 : Integer.parseInt(countReviewsText);
                }
                catch (Exception e){
                    log.info("У товара в Ozon рейтинг и количество заказов не найдено");
                }


                // Фото
                String imageUrl = item.findElements(By.xpath(".//img[contains(@src, '.jpg')]")).getFirst().getAttribute("src");

                Card card = new Card(name, "Ozon", url, price, rating, countReviews, imageUrl, false);
                cards.add(card);
            }
            log.info("Результат поиска на Ozon готов");
            return searchingResultTitle;

        } catch (Exception e) {
            e.printStackTrace();
            log.info("Ошибка в Ozon");
            return productName;
        } finally {
            driver.quit();
        }
    }

    public void connectToMm(String productName, CopyOnWriteArrayList<Card> cards) {
        WebDriver driver = connectToWebDriver();

        try {
            connectToUrl("https://mm.ru/", driver);

            driver.manage().timeouts().pageLoadTimeout(Duration.ofSeconds(10));

            // Инициализация WebDriverWait
            WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(5));

            // Ожидание, пока поле поиска станет доступным
            WebElement searchBox = wait.until(ExpectedConditions.visibilityOfElementLocated(By.className("default-input")));
            searchBox.sendKeys(productName);

            // Ожидание, пока кнопка поиска станет кликабельной
            WebElement searchButton = wait.until(ExpectedConditions.elementToBeClickable(By.className("search-button")));
            ((JavascriptExecutor) driver).executeScript("arguments[0].click();", searchButton);

            // Ожидание загрузки результатов
            wait.until(ExpectedConditions.visibilityOfElementLocated(By.className("ui-card")));

            for (WebElement element: driver.findElements(By.className("title")))
            {
                if (element.getText().equals("Мы не нашли то, что вы искали")){
                    log.info("Магнит маркет: Мы не нашли то, что вы искали");
                    return;
                }
            }

            // Повторное получение элементов
            List<WebElement> productItems = driver.findElements(By.className("ui-card"));

            // Обработка каждого товара
            for (WebElement item : productItems) {
                // Название
                String name = item.findElement(By.className("subtitle-item")).getText();

                // Цена
                String priceText = item.findElement(By.className("product-card-price"))
                        .getText()
                        .replaceAll("[^\\d]", "");
                int price = priceText.isEmpty() ? 0 : Integer.parseInt(priceText);

                // Ссылка на товар
                String url = item.findElement(By.cssSelector("a")).getAttribute("href");

                List<String> ratingAndCountReviews = List.of(item.findElement(By.className("orders")).getText().split("\n"));

                double rating = 0;
                int countReviews = 0;
                try {
                    // Рейтинг
                    String ratingText = ratingAndCountReviews.getFirst();
                    rating = ratingText.isEmpty() ? 0 : Double.parseDouble(ratingText);

                    // Количество заказов
                    String countReviewsText = ratingAndCountReviews.get(1).split(" ")[0];
                    countReviewsText = countReviewsText.substring(1, countReviewsText.length());
                    countReviews = countReviewsText.isEmpty() ? 0 : Integer.parseInt(countReviewsText);
                }
                catch (Exception e){
                    log.info("У товара в Магнит Маркете рейтинг и количество заказов не найдено");
                }

                // Фото
                String imageUrl = item.findElement(By.className("main-card-icon-and-classname-collision-made-to-minimum")).getAttribute("src");

                Card card = new Card(name, "Магнит Маркет", url, price, rating, countReviews, imageUrl, false);
                cards.add(card);
            }
            log.info("Результат поиска на Магнит Маркете готов");

        } catch (Exception e) {
            e.printStackTrace();
            log.info("Ошибка в Магнит Маркет");
        } finally {
            driver.quit();
        }
    }

    public String connectToYm(String productName, CopyOnWriteArrayList<Card> cards) {
        WebDriver driver = connectToWebDriver();
        try {
            connectToUrl("https://market.yandex.ru/", driver);

            // Инициализация WebDriverWait
            WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(5));

            // Ожидание, пока поле поиска станет доступным
            WebElement searchBox = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("header-search")));
            searchBox.sendKeys(productName);

            // Ожидание, пока кнопка поиска станет кликабельной
            WebElement searchButton = wait.until(ExpectedConditions.elementToBeClickable(By.className("mini-suggest__button")));
            ((JavascriptExecutor) driver).executeScript("arguments[0].click();", searchButton);

            // Ожидание загрузки результатов
            wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//article[@data-auto='searchOrganic']")));

            // Повторное получение элементов
            List<WebElement> productItems = driver.findElements(By.xpath("//article[@data-auto='searchOrganic']"));

            String searchingResultTitle = null;
            try {
                searchingResultTitle = driver.findElement(By.xpath(".//span[@class='_2SUA6 _33utW _13aK2 _1A5yJ']")).getText();
                searchingResultTitle = searchingResultTitle.substring(1, 2).toUpperCase() + searchingResultTitle.substring(2, searchingResultTitle.length() - 1);
            }
            catch (Exception e){
                searchingResultTitle = productName;
            }

            // Обработка каждого товара
            for (WebElement item : productItems) {
                // Ссылка на товар
                WebElement productLink = item.findElement(By.xpath(".//a[@data-auto='galleryLink']"));
                String url = productLink.getAttribute("href");

                // Фото
                WebElement productImage = item.findElement(By.xpath(".//img[@class='w7Bf7']"));
                String imageUrl = productImage.getAttribute("src");

                // Название
                String name = productImage.getAttribute("alt");

                // Цена
                WebElement priceElement = item.findElement(By.className("ds-text_color_price-term"));
                String priceText = priceElement.getText().replaceAll("[^\\d]", "");
                int price = priceText.isEmpty() ? 0 : Integer.parseInt(priceText);

                // Рейтинг
                double rating = 0;
                int countReviews = 0;
                try{
                    // Рейтинг
                    WebElement ratingElement = item.findElement(By.className("ds-text_color_text-rating"));
                    String ratingText = ratingElement.getText();
                    rating = ratingText.isEmpty() ? 0 : Double.parseDouble(ratingText);

                    // Количество заказов
                    String countReviewsText = item.findElement(By.className("ds-text_color_text-secondary"))
                            .getText()
                            .split(" ")[0];
                    countReviews = countReviewsText.isEmpty() ? 0 : Integer.parseInt(countReviewsText);
                }
                catch (Exception e){
                    log.info("У товара в Яндекс Маркете рейтинг и количество заказов не найдено");
                }


                Card card = new Card(name, "Яндекс Маркет", url, price, rating, countReviews, imageUrl, false);
                cards.add(card);
            }
            log.info("Результат поиска на Яндекс Маркете готов");
            return searchingResultTitle;

        } catch (Exception e) {
            e.printStackTrace();
            log.info("Ошибка в Яндекс Маркете");
            return productName;
        } finally {
            driver.quit();
        }
    }

    public Card checkPriceWb(String url)  {
        WebDriver driver = connectToWebDriver();
        try {
            connectToUrl(url, driver);

            // Инициализация WebDriverWait
            WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(15));
            // Ожидание загрузки результатов
            wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector(".product-page__grid")));
            WebElement webElement = driver.findElement(By.cssSelector(".product-page__grid"));


            // Название
            String name = webElement.findElement(By.cssSelector(".product-page__title"))
                    .getText()
                    .replace("/ ", "");

            // Цена
            String priceText = webElement.findElement(By.cssSelector(".price-block__final-price"))
                    .getText()
                    .replaceAll("[^\\d]", "");
            int price = priceText.isEmpty() ? 0 : Integer.parseInt(priceText);

            // Рейтинг
            String ratingText = webElement.findElement(By.cssSelector(".product-review__rating"))
                    .getText()
                    .replaceAll(",", ".");
            double rating = ratingText.isEmpty() ? 0 : Double.parseDouble(ratingText);

            // Количество отзывов
            String countReviewsText = webElement.findElement(By.cssSelector(".product-review__count-review"))
                    .getText()
                    .replaceAll(" оценки", "")
                    .replaceAll("[^\\d]", "");
            int countReviews = countReviewsText.isEmpty() ? 0 : Integer.parseInt(countReviewsText);

            // Фото
            String imageUrl = webElement.findElement(By.cssSelector(".photo-zoom__preview")).getAttribute("src");

            Card card = new Card(name, "Wildberries", url, price, rating, countReviews, imageUrl, false);

            log.info("Обновлена цена товара");
            return card;

        } catch (Exception e) {
            e.printStackTrace();
            log.info("Ошибка в Wildberries или товар удален");
            return null;
        } finally {
            driver.quit();
        }
    }

    public Card checkPriceOzon(String url) {
        WebDriver driver = connectToWebDriver();
        try {
            connectToUrl(url, driver);

            // Инициализация WebDriverWait
            WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));

            // Ожидание загрузки результатов
            wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//div[contains(@style, 'width:100%')]")));
            WebElement webElement = driver.findElement(By.xpath("//div[contains(@style, 'width:100%')]"));

            // Название
            String name = webElement.findElement(By.cssSelector(".tsHeadline550Medium")).getText();

            // Цена
            String priceText = driver.findElement(By.xpath("//*[@id=\"layoutPage\"]/div[1]/div[3]/div[3]/div[2]/div/div/div[1]/div[3]/div/div[1]/div/div/div[1]/div[2]/div/div[1]/span[1]"))
                    .getText()
                    .replaceAll("[^\\d]", "")
                    .replaceAll("₽", "");
            int price = priceText.isEmpty() ? 0 : Integer.parseInt(priceText);

            String[] ratingAndRewiews = webElement.findElement(By.cssSelector(".tsBodyControl500Medium"))
                    .getText()
                    .split(" • ");

            // Рейтинг
            String ratingText = ratingAndRewiews[0];
            double rating = ratingText.isEmpty() ? 0 : Double.parseDouble(ratingText);

            // Количество отзывов
            String countReviewsText = ratingAndRewiews[1]
                    .replaceAll(" отзывов", "")
                    .replaceAll(" отзыв", "")
                    .replaceAll(" отзыва", "")
                    .replaceAll("[^\\d]", "");
            int countReviews = countReviewsText.isEmpty() ? 0 : Integer.parseInt(countReviewsText);

            // Фото
            String imageUrl = null;
            try {
                imageUrl = driver.findElement(By.xpath("//img[contains(@data-lcp-name, 'webGallery')]")).getAttribute("src");
            }
            catch (Exception e){
                log.info("Нет фотографии");
            }

            Card card = new Card(name, "Ozon", url, price, rating, countReviews, imageUrl, false);

            log.info("Обновлена цена товара");
            return card;

        } catch (Exception e) {
            e.printStackTrace();
            log.info("Ошибка в Ozon или товар удален");
            return null;
        } finally {
            driver.quit();
        }
    }

    public Card checkPriceMm(String url) {
        WebDriver driver = connectToWebDriver();
        try {
            connectToUrl(url, driver);

            // Инициализация WebDriverWait
            WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(5));

            // Ожидание загрузки результатов
            wait.until(ExpectedConditions.visibilityOfElementLocated(By.className("layout__body")));
            WebElement webElement = driver.findElement(By.className("layout__body"));

            // Название
            String name = webElement.findElement(By.className("title")).getText();

            // Цена
            String priceText = webElement.findElement(By.className("sell-price"))
                    .getText()
                    .replaceAll("[^\\d]", "");
            int price = priceText.isEmpty() ? 0 : Integer.parseInt(priceText);

            // Рейтинг
            String ratingText = webElement.findElement(By.className("rating-value")).getText();
            double rating = ratingText.isEmpty() ? 0 : Double.parseDouble(ratingText);

            // Количество отзывов
            String countReviewsText = webElement.findElement(By.className("reviews_pointer"))
                .getText()
                .replaceAll("\\(", "")
                .replaceAll("\\)", "")
                .replaceAll(" отзывов", "")
                .replaceAll(" отзыв", "")
                .replaceAll(" отзыва", "")
                .replaceAll("[^\\d]", "");
            int countReviews = countReviewsText.isEmpty() ? 0 : Integer.parseInt(countReviewsText);

            // Фото
            String imageUrl = webElement.findElement(By.className("main-photo__content__image"))
                    .getAttribute("src");

            Card card = new Card(name, "Магнит Маркет", url, price, rating, countReviews, imageUrl, false);

            log.info("Обновлена цена товара");
            return card;

        } catch (Exception e) {
            e.printStackTrace();
            log.info("Ошибка в Магнит Маркет");
            return null;
        } finally {
            driver.quit();
        }
    }

    public Card checkPriceYM(String url) {
        WebDriver driver = connectToWebDriver();
        try {
            connectToUrl(url, driver);

            // Ожидание загрузки результатов
            WebElement webElement = driver.findElement(By.xpath("//div[@data-zone-name='product-page']"));

            // Название
            String name = webElement.findElement(By.xpath("//h1[@data-additional-zone='title']")).getText();

            // Цена
            String priceText = webElement.findElement(By.cssSelector("span._2r9lI[data-auto='snippet-price-old']"))
                    .getText()
                    .split("\n")[2]
                    .split("[^\\d]")[0];
            int price = priceText.isEmpty() ? 0 : Integer.parseInt(priceText);

            // Рейтинг
            String ratingText = webElement.findElement(By.xpath("//span[@data-auto='ratingValue']")).getText();
            double rating = ratingText.isEmpty() ? 0 : Double.parseDouble(ratingText);

            // Количество отзывов
            String countReviewsText = webElement.findElement(By.xpath("//span[@data-auto='ratingCount']"))
                    .getText()
                    .replaceAll("\\(", "")
                    .replaceAll("\\)", "");
            if (countReviewsText.contains("K")){
                countReviewsText = countReviewsText.replace("K", "000");
            }
            int countReviews = countReviewsText.isEmpty() ? 0 : Integer.parseInt(countReviewsText);

            // Фото
            String imageUrl = webElement.findElement(By.id("transition-page")).getAttribute("src");

            Card card = new Card(name, "Яндекс Маркет", url, price, rating, countReviews, imageUrl, false);

            log.info("Обновлена цена товара");
            return card;

        } catch (Exception e) {
            e.printStackTrace();
            log.info("Ошибка в Яндекс Маркете или товар удален");
            return null;
        } finally {
            driver.quit();
        }
    }

    private static WebDriver connectToWebDriver() {
        System.setProperty("webdriver.chrome.driver", "selenium\\chromedriver.exe");

        ChromeOptions options = new ChromeOptions();
        options.addArguments("--disable-extensions");
        options.addArguments("--disable-gpu");
        options.addArguments("--no-sandbox");
        options.addArguments("--disable-dev-shm-usage");

        options.setPageLoadStrategy(PageLoadStrategy.EAGER);
        options.addArguments("--disable-blink-features=AutomationControlled"); // Отключение флага автоматизации

        System.setProperty("webdriver.chrome.driver", "selenium\\chromedriver.exe");

        WebDriver driver = new ChromeDriver(options);
        return driver;
    }

    private static void connectToUrl(String url, WebDriver driver) {
        driver.get(url);
        log.info("Подключено к {}", url);
    }
}
