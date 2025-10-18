package com.io.example.dbReader.mapper;

import com.io.example.dbReader.model.dto.TestDto;
import com.io.example.dbReader.model.entity.TestEntity;
import org.instancio.Instancio;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.junit.jupiter.MockitoExtension;

import static org.assertj.core.api.AssertionsForClassTypes.assertThat;

@ExtendWith(MockitoExtension.class)
@DisplayName("Unit tests for TestEntityToDtoMapper")
public class TestEntityToDtoMapperTest{

    @InjectMocks
    private TestEntityToDtoMapper mapper;

    @Test
    @DisplayName("should correctly map TestEntity to TestDto")
    void shouldMapEntityToDtoCorrectly() {

        TestEntity entity = Instancio.create(TestEntity.class);
        TestDto dto = mapper.process(entity);

        assertThat(dto).usingRecursiveComparison()
                       .isEqualTo(entity);

    }

}