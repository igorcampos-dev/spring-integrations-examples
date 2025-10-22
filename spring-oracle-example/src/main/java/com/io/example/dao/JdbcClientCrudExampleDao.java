package com.io.example.dao;

import com.io.example.dto.JdbcClientCrudExampleDto;
import com.io.example.exception.JdbcClientCrudExampleException;
import lombok.RequiredArgsConstructor;
import org.springframework.jdbc.core.simple.JdbcClient;
import org.springframework.stereotype.Component;
import java.util.List;

@Component
@RequiredArgsConstructor
public class JdbcClientCrudExampleDao {

    private final JdbcClient jdbc;

    public void create(JdbcClientCrudExampleDto record) {
        try {
            jdbc.sql("""
                    INSERT INTO developer.records_example (id, name, value)
                    VALUES (?, ?, ?)
                    """)
                    .param(record.getId())
                    .param(record.getName())
                    .param(record.getValue())
                    .update();
        } catch (Exception e) {
            throw new JdbcClientCrudExampleException("Failed to insert record: " + record, e);
        }
    }

    public List<JdbcClientCrudExampleDto> findAll() {
        try {
            return jdbc.sql("""
                    SELECT id, name, value, created_at
                    FROM developer.records_example
                    """)
                    .query(JdbcClientCrudExampleDto.class)
                    .list();
        } catch (Exception e) {
            throw new JdbcClientCrudExampleException("Failed to retrieve all records", e);
        }
    }

    public JdbcClientCrudExampleDto findById(Long id) {
        try {
            return jdbc.sql("""
                    SELECT id, name, value, created_at
                    FROM developer.records_example
                    WHERE id = ?
                    """)
                    .param(id)
                    .query(JdbcClientCrudExampleDto.class)
                    .optional()
                    .orElseThrow(() -> new JdbcClientCrudExampleException("No record found for id = " + id));
        } catch (Exception e) {
            throw new JdbcClientCrudExampleException("Failed to retrieve record for id = " + id, e);
        }
    }

    public void update(Long id, String name, String value) {
        try {
            int affected = jdbc.sql("""
                    UPDATE developer.records_example
                    SET name = ?, value = ?
                    WHERE id = ?
                    """)
                    .param(name)
                    .param(value)
                    .param(id)
                    .update();

            if (affected == 0) {
                throw new JdbcClientCrudExampleException("No record found to update for id = " + id);
            }

        } catch (Exception e) {
            throw new JdbcClientCrudExampleException("Failed to update record with id = " + id, e);
        }
    }

    public void delete(Long id) {
        try {
            int affected = jdbc.sql("""
                    DELETE FROM developer.records_example
                    WHERE id = ?
                    """)
                    .param(id)
                    .update();

            if (affected == 0) {
                throw new JdbcClientCrudExampleException("No record found to delete for id = " + id);
            }

        } catch (Exception e) {
            throw new JdbcClientCrudExampleException("Failed to delete record with id = " + id, e);
        }
    }

}
