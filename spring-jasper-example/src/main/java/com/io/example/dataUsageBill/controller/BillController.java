package com.io.example.dataUsageBill.controller;

import com.io.example.clientList.service.ClientsReportService;
import com.io.example.dataUsageBill.service.BillReportService;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Profile;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Profile({"bill-dev", "bill-local"})
@RequiredArgsConstructor
public class BillController {

    private final BillReportService billReportService;

    @GetMapping("/reports/bill")
    public ResponseEntity<byte[]> getBillData() {
        byte[] pdf = this.billReportService.generateBillPdf();
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=bill.pdf")
                .contentType(MediaType.APPLICATION_PDF)
                .body(pdf);
    }

}
