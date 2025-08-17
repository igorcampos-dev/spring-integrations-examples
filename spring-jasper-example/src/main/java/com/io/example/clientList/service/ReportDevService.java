package com.io.example.clientList.service;

import com.io.example.clientList.dto.ClientDto;
import net.sf.jasperreports.engine.*;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import org.springframework.context.annotation.Profile;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;

import java.io.InputStream;
import java.util.*;

@Service
@Profile({"client-list-dev"})
public class ReportDevService implements ReportService {

    private static final List<ClientDto> clients = Arrays.asList(
            new ClientDto(1, "Alice", "Brazil"),
            new ClientDto(2, "Bob", "USA"),
            new ClientDto(3, "Carlos", "Spain")
    );

    @Override
    public byte[] generateClientReport() {
        return this.exportReportToPdf();
    }

    /*
     * TODO: In the future, this should be migrated to use:
     *
     * InputStream stream = new ClassPathResource("reports/client-list.jasper").getInputStream();
     * JasperReport jasperReport = (JasperReport) JRLoader.loadObject(stream);
     *
     * This approach is the recommended way in production environments.
     */

    private byte[] exportReportToPdf(){
        try {
            InputStream stream = new ClassPathResource("reports/client-list.jrxml").getInputStream();
            JasperReport jasperReport = JasperCompileManager.compileReport(stream);
            JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(clients);
            JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, new HashMap<>(), dataSource);
            return JasperExportManager.exportReportToPdf(jasperPrint);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
