package com.io.example.controller;

import com.io.example.dto.ExecutionDto;
import com.io.example.service.FileBatchService;
import lombok.RequiredArgsConstructor;
import org.springframework.batch.core.BatchStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/job")
@RequiredArgsConstructor
public class StudentController {

    private final FileBatchService fileBatchService;

    @PostMapping("/process")
    public ResponseEntity<Long> processJob(@RequestBody ExecutionDto dto){
        var response = fileBatchService.runJob(dto);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/{jobId}/status")
    public ResponseEntity<String> getJobStatus(@PathVariable Long jobId) {
        BatchStatus status = fileBatchService.getJobStatus(jobId);
        return ResponseEntity.ok(status.name());
    }

}
