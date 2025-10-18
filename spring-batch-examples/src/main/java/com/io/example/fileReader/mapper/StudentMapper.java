package com.io.example.fileReader.mapper;

import com.io.example.fileReader.dto.StudentDto;
import org.springframework.batch.extensions.excel.RowMapper;
import org.springframework.batch.extensions.excel.support.rowset.RowSet;
import java.time.LocalDate;

public class StudentMapper implements RowMapper<StudentDto>  {

    @Override
    public StudentDto mapRow(RowSet rowSet){
        String[] cells = rowSet.getCurrentRow();
        return StudentDto.builder()
                .nome(cells[0])
                .turma(cells[1])
                .data(LocalDate.parse(cells[2]))
                .build();
    }

}
