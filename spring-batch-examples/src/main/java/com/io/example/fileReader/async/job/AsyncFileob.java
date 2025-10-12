package com.io.example.fileReader.async.job;

import lombok.RequiredArgsConstructor;
import org.springframework.batch.core.Job;
import org.springframework.batch.core.Step;
import org.springframework.batch.core.job.builder.JobBuilder;
import org.springframework.batch.core.repository.JobRepository;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class AsyncFileob {

    @Bean
    public Job excelJob(JobRepository jobRepository, Step step) {
        return new JobBuilder("excelJob", jobRepository)
                .start(step)
                .build();
    }

}
