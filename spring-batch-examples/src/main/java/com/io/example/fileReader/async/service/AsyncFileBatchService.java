package com.io.example.fileReader.async.service;

import org.springframework.batch.core.BatchStatus;

public interface AsyncFileBatchService {
    Long runJob();
    BatchStatus getJobStatus(Long jobId);
}
