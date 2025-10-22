package com.io.example.init;

import com.io.example.dao.JdbcClientCrudExampleDao;
import com.io.example.dto.JdbcClientCrudExampleDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Slf4j
@Component
@RequiredArgsConstructor
public class JdbcClientCrudExampleInit implements CommandLineRunner {

    private final JdbcClientCrudExampleDao dao;

    @Override
    public void run(String... args) {

        var entity = JdbcClientCrudExampleDto.builder()
                .id(1L)
                .name("Test Name")
                .value("Some value")
                .build();

        dao.create(entity);
        log.info("Inserted: {}", entity);

        JdbcClientCrudExampleDto fetched = dao.findById(1L);
        log.info("Fetched: {}", fetched);

        fetched.setName("Updated Name");
        fetched.setValue("Updated value");

        dao.update(fetched.getId(), fetched.getName(), fetched.getValue());
        log.info("Updated: {}", fetched);

        dao.delete(1L);
        log.info("Deleted entity with id 1");

    }

}
