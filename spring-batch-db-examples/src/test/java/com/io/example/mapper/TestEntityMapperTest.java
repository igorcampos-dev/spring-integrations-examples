package com.io.example.mapper;

import com.io.example.model.dto.TestDto;
import com.io.example.model.entity.TestEntity;
import org.instancio.Instancio;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.junit.jupiter.MockitoExtension;

import static org.assertj.core.api.AssertionsForClassTypes.assertThat;

@ExtendWith(MockitoExtension.class)
@DisplayName("Unit tests for TestEntityToDtoMapper")
public class TestEntityMapperTest {

    @InjectMocks
    private TestEntityMapper mapper;

    @Test
    @DisplayName("should correctly map TestEntity to TestDto")
    void shouldMapEntityToDtoCorrectly() {

        TestEntity entity = Instancio.create(TestEntity.class);
        TestDto dto = mapper.process(entity);

        assertThat(dto).usingRecursiveComparison()
                       .isEqualTo(entity);

    }

}