package com.io.example.mapper;

import com.io.example.dto.StudentDto;
import org.springframework.batch.extensions.excel.RowMapper;
import org.springframework.batch.extensions.excel.support.rowset.RowSet;

import java.time.LocalDate;

public class StudentMapper implements RowMapper<StudentDto>  {

    @Override
    public StudentDto mapRow(RowSet rowSet){
        String[] cells = rowSet.getCurrentRow();
        return StudentDto.builder()
                .name(cells[0])
                .clasS(cells[1])
                .date(LocalDate.parse(cells[2]))
                .build();
    }

}
