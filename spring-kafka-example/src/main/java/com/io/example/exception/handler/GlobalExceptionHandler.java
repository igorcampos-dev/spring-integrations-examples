package com.io.example.exception.handler;

import com.io.example.exception.responseBody.Error;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@Slf4j
@ControllerAdvice
@SuppressWarnings("unused")
public class GlobalExceptionHandler {

    @ExceptionHandler(RuntimeException.class)
    public ResponseEntity<Error> handleRuntimeException(RuntimeException ex, HttpServletRequest s) {
        log.error("HandleRuntimeException= {}", ex.getMessage());
        return Error.response(ex.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR, s);
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<Error> handleMethodArgumentNotValidException(MethodArgumentNotValidException ex, HttpServletRequest s) {
        log.error("HandleMethodArgumentNotValidException= {}", ex.getMessage());
        return Error.response(this.getFirstErrorMessage(ex), HttpStatus.BAD_REQUEST, s);

    }

    private String getFirstErrorMessage(MethodArgumentNotValidException e) {
        return e.getBindingResult()
                .getFieldErrors()
                .stream()
                .findFirst()
                .map(FieldError::getDefaultMessage)
                .orElse(e.getMessage());
    }

}
