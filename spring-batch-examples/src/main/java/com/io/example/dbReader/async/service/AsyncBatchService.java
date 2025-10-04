package com.io.example.dbReader.async.service;

import org.springframework.batch.core.BatchStatus;

public interface AsyncBatchService {
    Long runJob();
    BatchStatus getJobStatus(Long jobId);
}
