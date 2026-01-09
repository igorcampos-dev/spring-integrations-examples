package com.io.example.config;

import com.io.example.dto.StudentDto;
import com.io.example.mapper.StudentMapper;
import com.io.example.service.StudentService;
import lombok.RequiredArgsConstructor;
import org.springframework.batch.core.Step;
import org.springframework.batch.core.configuration.annotation.StepScope;
import org.springframework.batch.core.repository.JobRepository;
import org.springframework.batch.core.step.builder.StepBuilder;
import org.springframework.batch.extensions.excel.poi.PoiItemReader;
import org.springframework.batch.item.ItemProcessor;
import org.springframework.batch.item.ItemWriter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.transaction.PlatformTransactionManager;

@Configuration
@RequiredArgsConstructor
public class SmallExcelReadBatchConfig {

    private final StudentService studentService;

    @Bean
    @StepScope
    public PoiItemReader<StudentDto> smallExcelReader(
            @Value("#{jobParameters['filePath']}") String filePath
    ) {
        PoiItemReader<StudentDto> reader = new PoiItemReader<>();
        reader.setResource(new ClassPathResource(filePath));
        reader.setLinesToSkip(1);
        reader.setRowMapper(new StudentMapper());
        return reader;
    }

    @Bean
    public ItemProcessor<StudentDto, StudentDto> smallExcelProcessor() {
        return student -> student;
    }

    @Bean
    public ItemWriter<StudentDto> smallExcelWriter() {
        return items -> items.forEach(studentService::print);
    }

    @Bean
    public Step smallExcelStep(JobRepository jobRepository,
                     PlatformTransactionManager transactionManager,
                     PoiItemReader<StudentDto> smallExcelReader,
                     ItemProcessor<StudentDto, StudentDto> smallExcelProcessor,
                     ItemWriter<StudentDto> smallExcelWriter,
                     @Value("${spring.batch.chunk-size}") int chunkSize) {

        return new StepBuilder("smallExcelStep", jobRepository)
                .<StudentDto, StudentDto>chunk(chunkSize, transactionManager)
                .reader(smallExcelReader)
                .processor(smallExcelProcessor)
                .writer(smallExcelWriter)
                .build();
    }
}
