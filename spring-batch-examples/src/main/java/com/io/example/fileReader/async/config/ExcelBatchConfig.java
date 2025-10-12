package com.io.example.fileReader.async.config;

import com.io.example.fileReader.async.service.TestService;
import com.io.example.fileReader.async.dto.StudentDto;
import com.io.example.fileReader.async.mapper.AlunoMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.batch.core.Step;
import org.springframework.batch.core.repository.JobRepository;
import org.springframework.batch.core.step.builder.StepBuilder;
import org.springframework.batch.extensions.excel.poi.PoiItemReader;
import org.springframework.batch.integration.async.AsyncItemProcessor;
import org.springframework.batch.integration.async.AsyncItemWriter;
import org.springframework.batch.item.ItemProcessor;
import org.springframework.batch.item.ItemWriter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.core.io.ClassPathResource;
import org.springframework.batch.core.configuration.annotation.StepScope;
import org.springframework.core.task.SimpleAsyncTaskExecutor;
import org.springframework.transaction.PlatformTransactionManager;
import java.util.concurrent.Future;

@Configuration
@RequiredArgsConstructor
@Profile("asyncExcelFileReader")
public class ExcelBatchConfig {

    private final TestService testService;

    @Bean
    @StepScope
    public PoiItemReader<StudentDto> excelReader() {
        PoiItemReader<StudentDto> reader = new PoiItemReader<>();
        reader.setResource(new ClassPathResource("students.xlsx"));
        reader.setRowMapper(new AlunoMapper());
        reader.setLinesToSkip(1);
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
                      PoiItemReader<StudentDto> reader ) {

        return new StepBuilder("step", jobRepository)
                .<StudentDto, Future<StudentDto>>chunk(1, transactionManager)
                .processor(processor)
                .writer(writer)
                .reader(reader)
                .build();
    }

}
