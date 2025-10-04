package com.io.example.dbReader.async.util;

import com.io.example.dbReader.async.model.entity.TestEntity;
import lombok.SneakyThrows;
import org.instancio.Instancio;
import org.springframework.batch.core.JobParameters;
import org.springframework.batch.core.JobParametersBuilder;
import org.springframework.batch.item.database.JdbcPagingItemReader;

import static org.mockito.BDDMockito.given;

public class DataUtils {

    public static JobParameters getParameters(){
        return new JobParametersBuilder()
                .addLong("time", System.currentTimeMillis())
                .toJobParameters();
    }

    public static TestEntity createRandomTestEntity(){
        return Instancio.create(TestEntity.class);
    }

    @SneakyThrows(Exception.class)
    public static void configJdbcPagingItemReaderMock(JdbcPagingItemReader<TestEntity> reader){
        given(reader.read())
                .willReturn(createRandomTestEntity())
                .willReturn(createRandomTestEntity())
                .willReturn(createRandomTestEntity())
                .willReturn(createRandomTestEntity())
                .willReturn(createRandomTestEntity())
                .willReturn(null);
    }

}
