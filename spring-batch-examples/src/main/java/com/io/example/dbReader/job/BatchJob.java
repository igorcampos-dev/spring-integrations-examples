package com.io.example.dbReader.job;

import lombok.RequiredArgsConstructor;
import org.springframework.batch.core.Job;
import org.springframework.batch.core.Step;
import org.springframework.batch.core.job.builder.JobBuilder;
import org.springframework.batch.core.repository.JobRepository;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class BatchJob {

    @Bean
    public Job job(JobRepository jobRepository, Step asyncStep) {
        return new JobBuilder("asyncBatchJob", jobRepository)
                .start(asyncStep)
                .build();
    }

}
