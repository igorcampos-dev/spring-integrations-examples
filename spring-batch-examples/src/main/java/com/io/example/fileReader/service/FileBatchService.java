package com.io.example.fileReader.service;

import org.springframework.batch.core.BatchStatus;

public interface FileBatchService {
    Long runJob();
    BatchStatus getJobStatus(Long jobId);
}
