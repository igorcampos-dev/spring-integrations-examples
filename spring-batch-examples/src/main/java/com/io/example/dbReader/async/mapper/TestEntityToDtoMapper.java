package com.io.example.dbReader.async.mapper;

import com.io.example.dbReader.async.model.dto.TestDto;
import com.io.example.dbReader.async.model.entity.TestEntity;
import org.springframework.batch.item.ItemProcessor;

public class TestEntityToDtoMapper implements ItemProcessor<TestEntity, TestDto> {

    @Override
    public TestDto process(TestEntity entity) {
        return TestDto.builder()
                .id(entity.getId())
                .fieldA(entity.getFieldA())
                .fieldB(entity.getFieldB())
                .fieldC(entity.getFieldC())
                .fieldD(entity.getFieldD())
                .fieldE(entity.isFieldE())
                .build();
    }

}
