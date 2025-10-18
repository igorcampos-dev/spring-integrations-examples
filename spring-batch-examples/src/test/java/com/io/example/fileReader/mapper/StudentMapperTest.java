package com.io.example.fileReader.mapper;

import com.io.example.fileReader.dto.StudentDto;
import org.junit.jupiter.api.Test;
import org.instancio.Instancio;
import org.springframework.batch.extensions.excel.support.rowset.RowSet;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.*;

class StudentMapperTest {

    @Test
    void shouldMapRowSetUsingInstancio() {
        StudentDto sample = Instancio.create(StudentDto.class);

        RowSet rowSet = mock(RowSet.class);
        when(rowSet.getCurrentRow()).thenReturn(new String[]{
                sample.getNome(),
                sample.getTurma(),
                sample.getData().toString()
        });

        StudentMapper mapper = new StudentMapper();
        StudentDto dto = mapper.mapRow(rowSet);

        assertEquals(sample, dto);
    }
}
