package com.io.example.repository;

import lombok.RequiredArgsConstructor;
import org.springframework.jdbc.core.simple.JdbcClient;
import org.springframework.stereotype.Repository;

@Repository
@RequiredArgsConstructor
public class CaffeineDescriptionRepository {

    private final JdbcClient client;

    public String findCaffeineDescription(){
        return client.sql("""
                    SELECT description
                    FROM caffeine_description
                    WHERE id = :id
                """)
                .param("id", "1")
                .query(String.class)
                .single();
    }

}
