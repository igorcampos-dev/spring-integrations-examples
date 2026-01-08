package com.io.example.service;

import com.io.example.dto.ExecutionDto;
import org.springframework.batch.core.BatchStatus;

public interface FileBatchService {
    Long runJob(ExecutionDto dto);
    BatchStatus getJobStatus(Long jobId);
}
