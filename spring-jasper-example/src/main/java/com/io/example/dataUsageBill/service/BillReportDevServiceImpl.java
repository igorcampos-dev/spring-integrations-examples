package com.io.example.dataUsageBill.service;

import com.io.example.dataUsageBill.dto.BillDto;
import org.springframework.context.annotation.Profile;
import org.springframework.stereotype.Service;

import java.util.List;

import static com.io.example.base.JasperReader.exportReportJasperToPdf;

@Service
@Profile({"bill-dev"})
public class BillReportDevServiceImpl implements BillReportService {

    @Override
    public byte[] generateBillPdf() {
        return exportReportJasperToPdf(getBillDto(), "reports/bill-template.jasper");
    }

    private List<BillDto> getBillDto(){
        BillDto bill = BillDto.builder()
                .orgName("My Organization")
                .depName("IT Department")
                .devName("Development Team")
                .groupName("Network Group")
                .dayStart("2025-08-01")
                .dayEnd("2025-08-31")
                .dtoOM(10)
                .dtoON(5)
                .dtoOL(3)
                .dtoDL(7)
                .dtoDN(2)
                .dtoD(1)
                .dtoOMamount(100)
                .dtoONamount(50)
                .dtoOLamount(30)
                .dtoDLamount(70)
                .dtoDNamount(20)
                .dtoDamount(10)
                .totalHrs(28)
                .toltalAm(280)
                .build();
        return List.of(bill);
    }

}
