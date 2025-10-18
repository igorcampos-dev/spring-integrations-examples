package com.io.example.controller;

import com.io.example.service.FileBatchService;
import lombok.RequiredArgsConstructor;
import org.springframework.batch.core.BatchStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/job")
@RequiredArgsConstructor
public class TestController {

    private final FileBatchService fileBatchService;

    @GetMapping("/process")
    public ResponseEntity<Long> processJob(){
        var response = fileBatchService.runJob();
        return ResponseEntity.ok(response);
    }

    @GetMapping("/{jobId}/status")
    public ResponseEntity<String> getJobStatus(@PathVariable Long jobId) {
        BatchStatus status = fileBatchService.getJobStatus(jobId);
        return ResponseEntity.ok(status.name());
    }

}
