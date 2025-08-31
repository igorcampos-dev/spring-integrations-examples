package com.io.example.clientList.service;

import com.io.example.clientList.dto.ClientDto;
import org.springframework.context.annotation.Profile;
import org.springframework.stereotype.Service;
import java.util.*;

import static com.io.example.base.JasperReader.exportReportJasperToPdf;

@Service
@Profile({"client-list-dev"})
public class ClientsReportDevServiceImpl implements ClientsReportService {

    private static final List<ClientDto> clients = Arrays.asList(
            new ClientDto(1, "Alice", "Brazil"),
            new ClientDto(2, "Bob", "USA"),
            new ClientDto(3, "Carlos", "Spain")
    );

    @Override
    public byte[] generateClientsPdf() {
        return exportReportJasperToPdf(clients, "reports/client-list-template.jasper");
    }


}
