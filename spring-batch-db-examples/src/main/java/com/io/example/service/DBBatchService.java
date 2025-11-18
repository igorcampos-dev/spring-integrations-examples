package com.io.example.service;

import org.springframework.batch.core.BatchStatus;

public interface DBBatchService {
    Long runJob();
    BatchStatus getJobStatus(Long jobId);
}
