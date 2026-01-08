package com.io.example.job;

import com.io.example.dto.StudentDto;
import com.io.example.service.StudentService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;
import org.springframework.batch.core.BatchStatus;
import org.springframework.batch.core.Job;
import org.springframework.batch.core.JobExecution;
import org.springframework.batch.test.JobLauncherTestUtils;
import org.springframework.batch.test.context.SpringBatchTest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.bean.override.mockito.MockitoBean;

import java.util.Map;

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
    @Qualifier("smallExcelJob")
    private Job smallExcelJob;

    @Autowired
    @Qualifier("largeExcelJob")
    private Job largeExcelJob;

    private Map<String, Job> jobs;

    @MockitoBean
    private StudentService studentService;

    @BeforeEach
    void setUp() {
        jobs = Map.of(
                "SMALL_JOB", smallExcelJob,
                "LARGE_JOB", largeExcelJob
        );
    }

    @ParameterizedTest
    @ValueSource(strings = {
            "SMALL_JOB",
            "LARGE_JOB"
    })
    @DisplayName("Should execute ExcelJob and complete successfully reading real file")
    void shouldExecuteJobSuccessfully(String jobType) throws Exception {
        jobLauncherTestUtils.setJob(jobs.get(jobType));

        JobExecution execution =
                jobLauncherTestUtils.launchJob(getParameters("files/students.xlsx"));

        assertThat(execution.getStatus())
                .isEqualTo(BatchStatus.COMPLETED);

        verify(studentService, atLeastOnce()).print(any(StudentDto.class));
    }

    @ParameterizedTest
    @ValueSource(strings = {
            "SMALL_JOB",
            "LARGE_JOB"
    })
    @DisplayName("Should fail executing ExcelJob when reader throws exception")
    void shouldFailJobWhenReaderThrowsException(String jobType) throws Exception {
        jobLauncherTestUtils.setJob(jobs.get(jobType));

        JobExecution execution = jobLauncherTestUtils.launchJob(getParameters("files/students-error.xlsx"));

        assertThat(execution.getStatus()).isEqualTo(BatchStatus.FAILED);

        verify(studentService, never()).print(any(StudentDto.class));

    }

    @ParameterizedTest
    @ValueSource(strings = {
            "SMALL_JOB",
            "LARGE_JOB"
    })
    @DisplayName("Should execute ExcelJob and complete successfully when reader has no data")
    void shouldCompleteJobWithNoData(String jobType) throws Exception {
        jobLauncherTestUtils.setJob(jobs.get(jobType));

        JobExecution execution = jobLauncherTestUtils.launchJob(getParameters("files/students-empty.xlsx"));

        assertThat(execution.getStatus())
                .as("Job should complete successfully")
                .isEqualTo(BatchStatus.COMPLETED);

        verify(studentService, never()).print(any(StudentDto.class));

    }

}
