package com.io.example.config;

import com.io.example.dto.StudentDto;
import com.io.example.reader.StreamingExcelItemReader;
import com.io.example.service.StudentService;
import lombok.RequiredArgsConstructor;
import org.springframework.batch.core.Step;
import org.springframework.batch.core.configuration.annotation.StepScope;
import org.springframework.batch.core.repository.JobRepository;
import org.springframework.batch.core.step.builder.StepBuilder;
import org.springframework.batch.item.ItemProcessor;
import org.springframework.batch.item.ItemWriter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.transaction.PlatformTransactionManager;

import java.time.LocalDate;

@Configuration
@RequiredArgsConstructor
public class LargeExcelReadBatchConfig {

    private final StudentService studentService;

    @Bean
    @StepScope
    public StreamingExcelItemReader<StudentDto> largeExcelReader(
            @Value("#{jobParameters['filePath']}") String filePath
    ) {
        return new StreamingExcelItemReader<>(
                new ClassPathResource(filePath),
                row -> new StudentDto(
                        row.getCell(0).getStringCellValue(),
                        row.getCell(1).getStringCellValue(),
                        LocalDate.parse(row.getCell(2).getStringCellValue())
                )
        );
    }

    @Bean
    public ItemProcessor<StudentDto, StudentDto> largeExcelProcessor() {
        return student -> student;
    }

    @Bean
    public ItemWriter<StudentDto> largeExcelWriter() {
        return items -> items.forEach(studentService::print);
    }

    @Bean
    public Step largeExcelStep(
            JobRepository jobRepository,
            PlatformTransactionManager transactionManager,
            StreamingExcelItemReader<StudentDto> largeExcelReader,
            ItemProcessor<StudentDto, StudentDto> largeExcelProcessor,
            ItemWriter<StudentDto> largeExcelWriter,
            @Value("${spring.batch.chunk-size}") int chunkSize
    ) {
        return new StepBuilder("largeExcelStep", jobRepository)
                .<StudentDto, StudentDto>chunk(chunkSize, transactionManager)
                .reader(largeExcelReader)
                .processor(largeExcelProcessor)
                .writer(largeExcelWriter)
                .build();
    }

}
