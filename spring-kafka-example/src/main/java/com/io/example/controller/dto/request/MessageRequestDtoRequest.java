package com.io.example.controller.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

public record MessageRequestDtoRequest(
        @NotNull(message = "message cannot be null.")
        @NotBlank(message = "message cannot be blank.")
        String message
) {}
