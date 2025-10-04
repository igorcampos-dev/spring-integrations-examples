package com.io.example.dbReader.async.service.impl;

import com.io.example.dbReader.async.exception.BusinessException;
import com.io.example.dbReader.async.service.AsyncBatchService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.batch.core.*;
import org.springframework.batch.core.explore.JobExplorer;
import org.springframework.batch.core.launch.JobLauncher;
import org.springframework.stereotype.Service;

@Service
@Slf4j
@RequiredArgsConstructor
public class AsyncBatchServiceImpl implements AsyncBatchService {

    private final JobLauncher asyncJobLauncher;
    private final Job asyncBatchJob;
    private final JobExplorer jobExplorer;

    @Override
    public Long runJob() {
        String jobName = asyncBatchJob.getName();
        var parameters = getParameters();
        try {
            log.info("Starting async execution of job: {}", jobName);
            JobExecution jobExecution = asyncJobLauncher.run(asyncBatchJob, parameters);
            log.info("Job {} started with status: {}", jobName, jobExecution.getStatus());
            return jobExecution.getId();
        } catch (Exception e) {
            log.error("Error executing job {} asynchronously", jobName, e);
            throw new BusinessException(e.getMessage(), e);
        }
    }

    @Override
    public BatchStatus getJobStatus(Long jobId) {
        JobExecution jobExecution = jobExplorer.getJobExecution(jobId);
        if (jobExecution == null) {
            throw new BusinessException("JobExecution não encontrado para id: " + jobId);
        }
        return jobExecution.getStatus();
    }

    private JobParameters getParameters(){
        return new JobParametersBuilder()
                .addLong("time", System.currentTimeMillis())
                .toJobParameters();
    }

}
