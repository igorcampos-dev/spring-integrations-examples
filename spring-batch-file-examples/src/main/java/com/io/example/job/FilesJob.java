package com.io.example.job;

import lombok.RequiredArgsConstructor;
import org.springframework.batch.core.Job;
import org.springframework.batch.core.Step;
import org.springframework.batch.core.job.builder.JobBuilder;
import org.springframework.batch.core.repository.JobRepository;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class FilesJob {

    @Bean
    public Job smallExcelJob(JobRepository jobRepository, Step smallExcelStep) {
        return new JobBuilder("smallExcelJob", jobRepository)
                .start(smallExcelStep)
                .build();
    }

    @Bean
    public Job largeExcelJob(JobRepository jobRepository, Step largeExcelStep) {
        return new JobBuilder("largeExcelJob", jobRepository)
                .start(largeExcelStep)
                .build();
    }

}
