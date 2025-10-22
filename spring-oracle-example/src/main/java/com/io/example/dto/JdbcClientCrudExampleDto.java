package com.io.example.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class JdbcClientCrudExampleDto {

    private Long id;
    private String name;
    private String value;
    private LocalDateTime createdAt;

}