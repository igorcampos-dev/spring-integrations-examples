package com.io.example.exception.responseBody;

import jakarta.servlet.ServletRequest;
import jakarta.servlet.http.HttpServletRequest;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.server.ServerWebExchange;

import java.time.Instant;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Error {
    private String timestamp;
    private String path;
    private Integer status;
    private String error;

    public static ResponseEntity<Error> response(String message, HttpStatus status, HttpServletRequest uri){
        return ResponseEntity
                .status(status)
                .body(Error.builder()
                           .timestamp(getInstantNow())
                           .path(uri.getRequestURI())
                           .status(status.value())
                           .error(message)
                           .build());
    }

    private static String getInstantNow() {
        return Instant.now()
                      .atZone(ZoneId.systemDefault())
                      .format(DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss"));

    }

}