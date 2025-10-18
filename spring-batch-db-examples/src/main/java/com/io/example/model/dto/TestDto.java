package com.io.example.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class TestDto {

    private Long id;
    private String fieldA;
    private String fieldB;
    private int fieldC;
    private double fieldD;
    private boolean fieldE;

}