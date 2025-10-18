package com.io.example.config;

import com.io.example.service.TestService;
import com.io.example.dto.StudentDto;
import com.io.example.mapper.StudentMapper;
import lombok.RequiredArgsConstructor;
import lombok.SneakyThrows;
import org.springframework.batch.core.Step;
import org.springframework.batch.core.repository.JobRepository;
import org.springframework.batch.core.step.builder.StepBuilder;
import org.springframework.batch.extensions.excel.poi.PoiItemReader;
import org.springframework.batch.integration.async.AsyncItemProcessor;
import org.springframework.batch.integration.async.AsyncItemWriter;
import org.springframework.batch.item.ItemProcessor;
import org.springframework.batch.item.ItemWriter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.batch.core.configuration.annotation.StepScope;
import org.springframework.core.io.InputStreamResource;
import org.springframework.core.task.SimpleAsyncTaskExecutor;
import org.springframework.transaction.PlatformTransactionManager;

import java.io.IOException;
import java.io.InputStream;
import java.util.concurrent.Future;

@Configuration
@RequiredArgsConstructor
public class ExcelBatchConfig {

    private final TestService testService;

    @Bean
    @StepScope
    public PoiItemReader<StudentDto> excelReader(
            @Value("#{jobParameters['filePath']}") String filePath
    ) throws IOException {
        InputStream inputStream = new ClassPathResource(filePath).getInputStream();
        PoiItemReader<StudentDto> reader = new PoiItemReader<>();
        reader.setResource(new InputStreamResource(inputStream));
        reader.setLinesToSkip(1);
        reader.setRowMapper(new StudentMapper());
        return reader;
    }

    @Bean
    public AsyncItemProcessor<StudentDto, StudentDto> asyncProcessor(
            ItemProcessor<StudentDto, StudentDto> processor
    ) {
        AsyncItemProcessor<StudentDto, StudentDto> asyncProcessor = new AsyncItemProcessor<>();
        asyncProcessor.setDelegate(processor);
        asyncProcessor.setTaskExecutor(new SimpleAsyncTaskExecutor());
        return asyncProcessor;
    }

    @Bean
    public AsyncItemWriter<StudentDto> asyncWriter(
            ItemWriter<StudentDto> writer
    ) {
        AsyncItemWriter<StudentDto> asyncWriter = new AsyncItemWriter<>();
        asyncWriter.setDelegate(writer);
        return asyncWriter;
    }

    @Bean
    public ItemWriter<StudentDto> writer() {
        return studentsDto -> studentsDto.forEach(testService::print);
    }

    @Bean
    public ItemProcessor<StudentDto, StudentDto> processor() {
        return studentDto -> studentDto;
    }

    @Bean
    public Step step(JobRepository jobRepository,
                     PlatformTransactionManager transactionManager,
                     AsyncItemProcessor<StudentDto, StudentDto> processor,
                     AsyncItemWriter<StudentDto> writer,
                     PoiItemReader<StudentDto> reader,
                     @Value("${spring.batch.chunk-size}") int chunkSize) {
        return new StepBuilder("step", jobRepository)
                .<StudentDto, Future<StudentDto>>chunk(chunkSize, transactionManager)
                .processor(processor)
                .writer(writer)
                .reader(reader)
                .build();
    }

}
