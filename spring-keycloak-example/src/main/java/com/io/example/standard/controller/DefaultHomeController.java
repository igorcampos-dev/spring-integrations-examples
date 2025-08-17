package com.io.example.standard.controller;

import org.springframework.context.annotation.Profile;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@Profile("default")
@RestController
@SuppressWarnings("unused")
public class DefaultHomeController {

    @GetMapping("/public")
    public String publicPage() {
        return "This is a public page.";
    }

}
