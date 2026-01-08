package com.io.example.reader;

import com.github.pjfanning.xlsx.StreamingReader;
import lombok.SneakyThrows;
import org.apache.poi.ss.usermodel.*;
import org.springframework.batch.core.configuration.annotation.StepScope;
import org.springframework.batch.item.ExecutionContext;
import org.springframework.batch.item.ItemStreamReader;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.io.InputStream;
import java.util.Iterator;
import java.util.function.Function;

@Component
@StepScope
public class StreamingExcelItemReader<T>
        implements ItemStreamReader<T> {

    private final Resource resource;
    private final Function<Row, T> rowMapper;

    private Workbook workbook;
    private Iterator<Row> rowIterator;
    private int currentRow = 0;

    public StreamingExcelItemReader(
            Resource resource,
            Function<Row, T> rowMapper
    ) {
        this.resource = resource;
        this.rowMapper = rowMapper;
    }

    @Override
    @SneakyThrows(IOException.class)
    public void open(ExecutionContext context) {
        this.currentRow = context.getInt("current.row", 0);

        InputStream is = resource.getInputStream();
        this.workbook = StreamingReader.builder()
                .rowCacheSize(100)
                .bufferSize(4096)
                .open(is);

        Sheet sheet = workbook.getSheetAt(0);
        this.rowIterator = sheet.iterator();

        int linesToSkip = 1;
        int skip = Math.max(linesToSkip, currentRow);
        for (int i = 0; i < skip && rowIterator.hasNext(); i++) {
            rowIterator.next();
        }
    }

    @Override
    public T read() {
        while (rowIterator.hasNext()) {

            Row row = rowIterator.next();
            currentRow++;

            if (isRowEmpty(row)) {
                continue;
            }

            return rowMapper.apply(row);
        }

        return null;
    }

    @Override
    public void update(ExecutionContext context) {
        context.putInt("current.row", currentRow);
    }

    @Override
    @SneakyThrows(IOException.class)
    public void close() {
        if (workbook != null) {
            workbook.close();
        }
    }

    private boolean isRowEmpty(Row row) {
        if (row == null) return true;

        for (int i = row.getFirstCellNum(); i < row.getLastCellNum(); i++) {
            Cell cell = row.getCell(i);
            if (cell != null && cell.getCellType() != CellType.BLANK) {
                return false;
            }
        }

        return true;
    }


}
