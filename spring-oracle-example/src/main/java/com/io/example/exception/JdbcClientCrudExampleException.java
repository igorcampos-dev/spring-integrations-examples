package com.io.example.exception;

public class JdbcClientCrudExampleException extends RuntimeException {

    public JdbcClientCrudExampleException(String message) {
        super(message);
    }

    public JdbcClientCrudExampleException(String message, Throwable cause) {
        super(message, cause);
    }

}
