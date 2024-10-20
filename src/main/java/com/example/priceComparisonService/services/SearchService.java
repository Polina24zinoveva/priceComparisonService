package com.example.priceComparisonService.services;

import com.example.priceComparisonService.dto.Card;
import io.github.bonigarcia.wdm.WebDriverManager;
import lombok.extern.slf4j.Slf4j;
import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.openqa.selenium.*;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.springframework.stereotype.Service;

import java.io.Console;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.Duration;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Objects;
import java.util.concurrent.CopyOnWriteArrayList;

import static java.lang.Math.log;



@Service
@Slf4j
public class SearchService {

    public String connectToWb(String productName, CopyOnWriteArrayList<Card> cards) throws IOException {
        System.setProperty("webdriver.chrome.driver", "selenium\\chromedriver.exe");

        ChromeOptions options = new ChromeOptions();
        options.addArguments("--disable-blink-features=AutomationControlled"); // Отключение флага автоматизации

        System.setProperty("webdriver.chrome.driver", "selenium\\chromedriver.exe");

        WebDriver driver = new ChromeDriver(options);

        try {
            // Открытие сайта Wildberries
            driver.get("https://www.wildberries.ru/");

            log.info("Подключено к {}", "https://www.wildberries.ru/");

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
                String name = item.findElement(By.cssSelector(".product-card__name")).getText().replace("/ ", "");

                // Цена
                String priceText = item.findElement(By.cssSelector(".price__lower-price")).getText().replaceAll("[^\\d]", "");
                int price = 0;
                if (!priceText.isEmpty()) {
                    price = Integer.parseInt(priceText);
                }

                // Ссылка на товар
                String url = item.findElement(By.cssSelector("a")).getAttribute("href");

                // Рейтинг
                String ratingText = item.findElement(By.cssSelector(".address-rate-mini")).getText().replace(",", ".");
                double rating = 0;
                if (!ratingText.isEmpty()) {
                    rating = Double.parseDouble(ratingText);
                }

                // Количество заказов
                String countReviewsText = item.findElement(By.cssSelector(".product-card__count")).getText().replaceAll("[^\\d]", "");
                int countReviews = 0;
                if (!countReviewsText.isEmpty()) {
                    countReviews = Integer.parseInt(countReviewsText);
                }

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
            // Закрытие браузера
            driver.quit();
        }
    }


    public String connectToOzon(String productName, CopyOnWriteArrayList<Card> cards) throws IOException {

        ChromeOptions options = new ChromeOptions();
        options.addArguments("--disable-blink-features=AutomationControlled"); // Отключение флага автоматизации

        System.setProperty("webdriver.chrome.driver", "selenium\\chromedriver.exe");

        WebDriver driver = new ChromeDriver(options);

        try {
            // Открытие сайта
            driver.get("https://www.ozon.ru/");
            log.info("Подключено к {}", "https://www.ozon.ru/");

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
                searchingResultTitle = driver.findElement(By.xpath("//*[@id=\"layoutPage\"]/div[1]/div[2]/div[1]/div/div[1]/div[1]/strong")).getText();
                searchingResultTitle = searchingResultTitle.substring(0, 1).toUpperCase() + searchingResultTitle.substring(1);
            }
            catch (Exception e){
                searchingResultTitle = productName;
            }

            // Обработка каждого товара
            for (WebElement item : productItems) {

                // Название
                String name = item.findElement(By.cssSelector(".tsBody500Medium")).getText().replace("/ ", "");

                // Цена
                String priceText = item.findElement(By.cssSelector(".tsHeadline500Medium")).getText().replaceAll("[^\\d]", "");
                int price = 0;
                if (!priceText.isEmpty()) {
                    price = Integer.parseInt(priceText);
                }

                // Ссылка на товар
                String url = item.findElement(By.cssSelector("a")).getAttribute("href");


                List<WebElement> ratingElements = item.findElements(By.xpath(".//span[contains(text(), '.')]"));
                String ratingText = "";
                for (WebElement webElement : ratingElements){
                    try {
                        ratingText = webElement.getText().replaceAll(" ", "");
                    }
                    catch (Exception e){
                        continue;
                    }
                }
                double rating = 0;
                if (!ratingText.isEmpty()) {
                    rating = Double.parseDouble(ratingText);
                }

                int countReviews = 0;

                List<WebElement> countReviewsElements =  item.findElements(By.xpath(".//span[contains(text(), 'отзыва')]"));
                if (countReviewsElements.isEmpty()){
                    countReviewsElements =  item.findElements(By.xpath(".//span[contains(text(), 'отзывов')]"));
                    if (countReviewsElements.isEmpty()){
                        countReviewsElements =  item.findElements(By.xpath(".//span[contains(text(), 'отзыв')]"));
                        if (!countReviewsElements.isEmpty()){
                            String countReviewsText = countReviewsElements.getFirst().getText().split(" ")[0].replaceAll("\\p{Zs}","");
                            countReviews = Integer.parseInt(countReviewsText);
                        }
                    }
                    else {
                        String countReviewsText = countReviewsElements.getFirst().getText().split(" ")[0].replaceAll("\\p{Zs}","");
                        countReviews = Integer.parseInt(countReviewsText);
                    }
                }
                else {
                    String countReviewsText = countReviewsElements.getFirst().getText().split(" ")[0].replaceAll("\\p{Zs}","");
                    countReviews = Integer.parseInt(countReviewsText);
                }

                // Фото
                String imageUrl;
                try {
                    imageUrl = item.findElements(By.xpath(".//img[contains(@src, '.jpg')]")).getFirst().getAttribute("src");
                }
                catch (Exception e){
                    imageUrl = null;
                }

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
            // Закрытие браузера
            driver.quit();
        }
    }

    public Card checkPriceWb(String url) throws IOException {

        System.setProperty("webdriver.chrome.driver", "selenium\\chromedriver.exe");

        ChromeOptions options = new ChromeOptions();
        options.addArguments("--disable-blink-features=AutomationControlled"); // Отключение флага автоматизации

        System.setProperty("webdriver.chrome.driver", "selenium\\chromedriver.exe");

        WebDriver driver = new ChromeDriver(options);

        try {
            // Открытие сайта Wildberries
            driver.get(url);

            log.info("Подключено к {}", url);

            // Инициализация WebDriverWait
            WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(15));
            // Ожидание загрузки результатов
            wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector(".product-page__grid")));
            WebElement webElement = driver.findElement(By.cssSelector(".product-page__grid"));


            // Название
            String name = webElement.findElement(By.cssSelector(".product-page__title")).getText().replace("/ ", "");
            // Цена
            String priceText = webElement.findElement(By.cssSelector(".price-block__final-price")).getText().replaceAll("[^\\d]", "");
            int price = 0;
            if (!priceText.isEmpty()) {
                price = Integer.parseInt(priceText);
            }


            // Рейтинг
            String ratingText = webElement.findElement(By.cssSelector(".product-review__rating")).getText();
            double rating = 0;
            if (!ratingText.isEmpty()) {
                rating = Double.parseDouble(ratingText);
            }

            // Количество отзывов
            String countReviewsText = webElement.findElement(By.cssSelector(".product-review__count-review")).getText().replaceAll(" оценки", "").replaceAll("[^\\d]", "");
            int countReviews = 0;
            if (!countReviewsText.isEmpty()) {
                countReviews = Integer.parseInt(countReviewsText);
            }

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
            // Закрытие браузера
            driver.quit();
        }
    }


    public Card checkPriceOzon(String url) throws IOException {

        ChromeOptions options = new ChromeOptions();
        options.addArguments("--disable-blink-features=AutomationControlled"); // Отключение флага автоматизации

        System.setProperty("webdriver.chrome.driver", "selenium\\chromedriver.exe");

        WebDriver driver = new ChromeDriver(options);

        // Открытие сайта Ozon
        driver.get(url);

        log.info("Подключено к {}", url);

        // Инициализация WebDriverWait
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));

        try {
            // Ожидание загрузки результатов
            wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//div[contains(@style, 'width:100%')]")));
            WebElement webElement = driver.findElement(By.xpath("//div[contains(@style, 'width:100%')]"));

            // Название
            String name = webElement.findElement(By.cssSelector(".tsHeadline550Medium")).getText();

            String priceText;
            // Цена
            try{
                priceText = webElement.findElement(By.xpath("//*[@id=\"layoutPage\"]/div[1]/div[4]/div[3]/div[2]/div[1]/div[3]/div/div[1]/div/div/div[1]/div[2]/div/div[1]/span[1]")).getText().replaceAll("[^\\d]", "");
            }
            catch (Exception e){
                try{
                    priceText = webElement.findElement(By.xpath("//*[@id=\"layoutPage\"]/div[1]/div[4]/div[3]/div[2]/div[1]/div[2]/div/div[1]/div/div/div[1]/div[2]/div/div[1]/span[1]")).getText().replaceAll("[^\\d]", "");
                                                                                //*[@id="layoutPage"]/div[1]/div[4]/div[3]/div[2]/div[1]/div[2]/div/div[1]/div/div/div[1]/div[2]/div/div[1]/span[1]
                } catch (Exception ex) {
                    throw new RuntimeException(ex);
                }
            }
            int price = 0;
            if (!priceText.isEmpty()) {
                price = Integer.parseInt(priceText);
            }

            //<div class="ga111-a2 tsBodyControl500Medium">5 • 30 отзывов</div>
            List<String> ratingAndRewiews = List.of(webElement.findElement(By.cssSelector(".tsBodyControl500Medium")).getText().split(" • "));

            String ratingText = ratingAndRewiews.getFirst();
            double rating = 0;
            int countReviews = 0;

            // Рейтинг
            if (Objects.equals(ratingText, "Добавить в корзину")){

            }
            else{
                if (!ratingText.isEmpty()) {
                    rating = Double.parseDouble(ratingText);
                }

                // Количество заказов
                String countReviewsText = ratingAndRewiews.get(1).split(" ")[0].replaceAll(" отзывов", "").replaceAll("\\p{Zs}","");
                if (!countReviewsText.isEmpty()) {
                    countReviews = Integer.parseInt(countReviewsText);
                }
            }


            // Фото
            String imageUrl;
            try {
                List<WebElement> images = webElement.findElements(By.xpath(".//img[contains(@src, '.jpg')]"));

                if (images.size() >= 3) {
                    imageUrl = images.get(2).getAttribute("src");
                } else {
                    imageUrl = null;
                }
            }
            catch (Exception e){
                imageUrl = null;
            }
            Card card = new Card(name, "Ozon", url, price, rating, countReviews, imageUrl, false);

            log.info("Обновлена цена товара");
            return card;

        } catch (Exception e) {
            e.printStackTrace();
            log.info("Ошибка в Ozon или товар удален");
            return null;
        } finally {
            // Закрытие браузера
            driver.quit();
        }
    }
}
