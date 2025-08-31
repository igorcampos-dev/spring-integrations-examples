package com.io.example.base;

import net.sf.jasperreports.engine.*;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.util.JRLoader;
import org.springframework.core.io.ClassPathResource;

import java.io.InputStream;
import java.util.Collection;
import java.util.HashMap;

public class JasperReader {

    public static byte[] exportReportJrxmlToPdf(Collection<?> beanCollection, String path){
        try {
            InputStream stream = new ClassPathResource(path).getInputStream();
            JasperReport jasperReport = JasperCompileManager.compileReport(stream);
            JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(beanCollection);
            JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, new HashMap<>(), dataSource);
            return JasperExportManager.exportReportToPdf(jasperPrint);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public static byte[] exportReportJasperToPdf(Collection<?> beanCollection, String path){
        try (InputStream stream = new ClassPathResource(path).getInputStream()) {
            JasperReport jasperReport = (JasperReport) JRLoader.loadObject(stream);
            JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(beanCollection);
            JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, new HashMap<>(), dataSource);
            return JasperExportManager.exportReportToPdf(jasperPrint);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
