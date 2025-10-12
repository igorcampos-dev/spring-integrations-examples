package com.io.example.fileReader.async.controller;

import com.io.example.fileReader.async.service.AsyncFileBatchService;
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

    private final AsyncFileBatchService asyncFileBatchService;

    @GetMapping("/process")
    public ResponseEntity<Long> processJob(){
        var response = asyncFileBatchService.runJob();
        return ResponseEntity.ok(response);
    }

    @GetMapping("/{jobId}/status")
    public ResponseEntity<String> getJobStatus(@PathVariable Long jobId) {
        try {
            BatchStatus status = asyncFileBatchService.getJobStatus(jobId);
            return ResponseEntity.ok(status.name());
        } catch (IllegalArgumentException e) {
            return ResponseEntity.notFound().build();
        }
    }

}
