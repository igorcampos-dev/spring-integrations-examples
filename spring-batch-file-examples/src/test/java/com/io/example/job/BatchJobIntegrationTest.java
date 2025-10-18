package com.io.example.job;

import com.io.example.dto.StudentDto;
import com.io.example.service.TestService;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.batch.core.*;
import org.springframework.batch.core.launch.JobLauncher;
import org.springframework.batch.extensions.excel.poi.PoiItemReader;
import org.springframework.batch.test.JobLauncherTestUtils;
import org.springframework.batch.test.context.SpringBatchTest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.bean.override.mockito.MockitoBean;

import static com.io.example.util.DataUtils.getParameters;
import static org.assertj.core.api.AssertionsForClassTypes.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@SpringBootTest
@SpringBatchTest
@ActiveProfiles("test")
@DisplayName("ExcelJob - Integration test with real Excel reading and job execution")
class BatchJobIntegrationTest {

    @Autowired
    private JobLauncherTestUtils jobLauncherTestUtils;

    @Autowired
    private PoiItemReader<StudentDto> excelReader;

    @MockitoBean
    private TestService testService;

    @Test
    @DisplayName("Should execute ExcelJob and complete successfully reading real file")
    void shouldExecuteJobSuccessfully() throws Exception {
        JobExecution execution = jobLauncherTestUtils.launchJob(getParameters("files/students.xlsx"));

        assertThat(execution.getStatus())
                .as("Job should complete successfully")
                .isEqualTo(BatchStatus.COMPLETED);

        verify(testService, atLeastOnce()).print(any(StudentDto.class));

    }

    @Test
    @DisplayName("Should fail executing ExcelJob when reader throws exception")
    void shouldFailJobWhenReaderThrowsException() throws Exception {

        JobExecution execution = jobLauncherTestUtils.launchJob(getParameters("files/students-error.xlsx"));

        assertThat(execution.getStatus()).isEqualTo(BatchStatus.FAILED);

        verify(testService, never()).print(any(StudentDto.class));

    }

    @Test
    @DisplayName("Should execute ExcelJob and complete successfully when reader has no data")
    void shouldCompleteJobWithNoData() throws Exception {

        JobExecution execution = jobLauncherTestUtils.launchJob(getParameters("files/students-empty.xlsx"));

        assertThat(execution.getStatus())
                .as("Job should complete successfully")
                .isEqualTo(BatchStatus.COMPLETED);

        verify(testService, never()).print(any(StudentDto.class));

    }

}
