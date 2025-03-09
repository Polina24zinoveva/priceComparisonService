package com.example.priceComparisonService.controllers;

import com.example.priceComparisonService.dto.Card;
import com.example.priceComparisonService.services.SearchService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.io.IOException;
import java.util.OptionalInt;

@Controller
public class MainPageController {
    SearchService searchService = new SearchService();

    @GetMapping("/")
    public String startPage(Model model) throws IOException {
        return "main2";
    }

    @GetMapping("/main")
    public String mainPage(Model model) throws IOException {
        return "main2";
    }
}
