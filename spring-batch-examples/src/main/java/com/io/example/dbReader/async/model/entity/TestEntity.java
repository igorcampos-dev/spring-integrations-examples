package com.io.example.dbReader.async.model.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Table(name = "test_entity")
@Entity
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class TestEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String fieldA;
    private String fieldB;
    private int fieldC;
    private double fieldD;
    private boolean fieldE;

}