package com.io.example.dbReader.async.controller;

import com.io.example.dbReader.async.service.AsyncBatchService;
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

    private final AsyncBatchService asyncBatchService;

    @GetMapping("/process")
    public ResponseEntity<Long> processJob(){
        var response = asyncBatchService.runJob();
        return ResponseEntity.ok(response);
    }

    @GetMapping("/{jobId}/status")
    public ResponseEntity<String> getJobStatus(@PathVariable Long jobId) {
        try {
            BatchStatus status = asyncBatchService.getJobStatus(jobId);
            return ResponseEntity.ok(status.name());
        } catch (IllegalArgumentException e) {
            return ResponseEntity.notFound().build();
        }
    }

}
