package com.io.example.clientList.controller;

import com.io.example.clientList.service.ReportService;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Profile;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Profile({"client-list-dev", "client-list-local"})
@RequiredArgsConstructor
public class ReportController {

    private final ReportService reportService;

    @GetMapping("/reports/clients")
    public ResponseEntity<byte[]> getClientsReport() {
        byte[] pdf = this.reportService.generateClientReport();
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=clients.pdf")
                .contentType(MediaType.APPLICATION_PDF)
                .body(pdf);
    }

}
