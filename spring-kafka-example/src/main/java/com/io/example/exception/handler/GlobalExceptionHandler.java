package com.io.example.exception.handler;

import com.io.example.exception.responseBody.Error;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@Slf4j
@ControllerAdvice
@SuppressWarnings("unused")
public class GlobalExceptionHandler {

    @ExceptionHandler(RuntimeException.class)
    public ResponseEntity<ResponseEntity<Error>> handleRuntimeException(RuntimeException ex, HttpServletRequest s) {
        log.error("HandleRuntimeException= {}", ex.getMessage());
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                             .body(Error.response(ex.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR, s));
    }


}
