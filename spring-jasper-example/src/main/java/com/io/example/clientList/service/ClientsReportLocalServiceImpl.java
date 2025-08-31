package com.io.example.clientList.service;

import com.io.example.clientList.dto.ClientDto;
import org.springframework.context.annotation.Profile;
import org.springframework.stereotype.Service;
import java.util.*;

import static com.io.example.base.JasperReader.exportReportJrxmlToPdf;

@Service
@Profile({"client-list-local"})
public class ClientsReportLocalServiceImpl implements ClientsReportService {

    private static final List<ClientDto> clients = Arrays.asList(
            new ClientDto(1, "Alice", "Brazil"),
            new ClientDto(2, "Bob", "USA"),
            new ClientDto(3, "Carlos", "Spain")
    );

    @Override
    public byte[] generateClientsPdf() {
        return exportReportJrxmlToPdf(clients, "reports/client-list-template.jrxml");
    }

}
