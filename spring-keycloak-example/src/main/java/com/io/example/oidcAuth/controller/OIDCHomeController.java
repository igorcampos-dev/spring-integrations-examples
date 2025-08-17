package com.io.example.oidcAuth.controller;

import org.springframework.context.annotation.Profile;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.core.oidc.user.OidcUser;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@Profile("OIDC")
@RestController
@SuppressWarnings("unused")
public class OIDCHomeController {

    @GetMapping("/public")
    public String publicPage() {
        return "This is a public page.";
    }

    @GetMapping("/secured")
    public String securedPage(@AuthenticationPrincipal OidcUser user) {
        return "Hello, " + user.getFullName() + "! You are authenticated.";
    }

}
