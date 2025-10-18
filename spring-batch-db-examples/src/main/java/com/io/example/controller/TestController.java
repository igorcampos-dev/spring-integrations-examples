package com.io.example.controller;

import com.io.example.exception.BusinessException;
import com.io.example.exception.GlobalHandlerException;
import com.io.example.service.DBBatchService;
import lombok.RequiredArgsConstructor;
import org.springframework.batch.core.BatchStatus;
import org.springframework.context.annotation.Import;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/job")
@RequiredArgsConstructor
@Import(GlobalHandlerException.class)
public class TestController {

    private final DBBatchService DBBatchService;

    @GetMapping("/process")
    public ResponseEntity<Long> processJob(){
        var response = DBBatchService.runJob();
        return ResponseEntity.ok(response);
    }

    @GetMapping("/{jobId}/status")
    public ResponseEntity<String> getJobStatus(@PathVariable Long jobId) {
        try {
            BatchStatus status = DBBatchService.getJobStatus(jobId);
            return ResponseEntity.ok(status.name());
        } catch (BusinessException e) {
            throw e;
        }
    }

}
