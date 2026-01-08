package com.io.example.service;

import com.io.example.dto.ExecutionDto;
import com.io.example.enums.JobsType;
import com.io.example.exception.BusinessException;
import com.io.example.service.impl.FileBatchServiceImpl;
import org.instancio.Instancio;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestInstance;
import org.junit.jupiter.api.extension.ExtendWith;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.Arguments;
import org.junit.jupiter.params.provider.MethodSource;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.batch.core.BatchStatus;
import org.springframework.batch.core.Job;
import org.springframework.batch.core.JobExecution;
import org.springframework.batch.core.JobParameters;
import org.springframework.batch.core.explore.JobExplorer;
import org.springframework.batch.core.launch.JobLauncher;

import java.util.HashMap;
import java.util.Map;
import java.util.stream.Stream;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class FileBatchServiceImplTest {

    private static final Long JOB_ID = Instancio.create(Long.class);

    @Mock
    private JobLauncher asyncJobLauncher;

    @Mock
    private JobExplorer jobExplorer;

    @Mock
    private Job job;

    @Mock
    private ExecutionDto executionDto;

    @Mock
    private JobExecution jobExecution;

    private FileBatchServiceImpl service;

    @BeforeEach
    void setup() {
        Map<String, Job> jobs = new HashMap<>();
        jobs.put(JobsType.SMALL_EXCEL.getJobName(), job);
        jobs.put(JobsType.LARGE_EXCEL.getJobName(), job);

        service = new FileBatchServiceImpl(jobs, asyncJobLauncher, jobExplorer);
    }

    @ParameterizedTest
    @MethodSource("scenarios")
    void shouldRunJobSuccessfully(String jobType, String jobName) throws Exception {

        when(executionDto.getType()).thenReturn(JobsType.valueOf(jobType));
        when(job.getName()).thenReturn(jobName);

        when(jobExecution.getId()).thenReturn(1L);
        when(jobExecution.getStatus()).thenReturn(BatchStatus.STARTED);

        when(asyncJobLauncher.run(any(Job.class), any(JobParameters.class))).thenReturn(jobExecution);

        Long executionId = service.runJob(executionDto);

        assertEquals(1L, executionId);

        verify(asyncJobLauncher).run(eq(job), any(JobParameters.class));
    }

    @ParameterizedTest
    @MethodSource("scenarios")
    @DisplayName("Should throw BusinessException when job execution fails")
    void shouldThrowBusinessExceptionWhenJobFails(String jobType, String jobName) throws Exception {

        when(job.getName()).thenReturn(jobName);
        when(asyncJobLauncher.run(any(Job.class), any(JobParameters.class))).thenThrow(new RuntimeException("Simulated error"));

        BusinessException exception = assertThrows(
                BusinessException.class,
                () -> service.runJob(new ExecutionDto(JobsType.valueOf(jobType)))
        );

        assertThat(exception.getMessage()).isEqualTo("Simulated error");
    }

    @Test
    @DisplayName("Should return job status when job execution exists")
    void shouldReturnJobStatus() {
        when(jobExecution.getStatus()).thenReturn(BatchStatus.COMPLETED);
        when(jobExplorer.getJobExecution(JOB_ID)).thenReturn(jobExecution);

        BatchStatus status = service.getJobStatus(JOB_ID);

        assertThat(status).isEqualTo(BatchStatus.COMPLETED);
        verify(jobExplorer).getJobExecution(JOB_ID);
    }

    @Test
    @DisplayName("Should throw BusinessException when job execution not found")
    void shouldThrowBusinessExceptionWhenJobNotFound() {
        when(jobExplorer.getJobExecution(JOB_ID)).thenReturn(null);

        BusinessException exception = assertThrows(BusinessException.class,
                () -> service.getJobStatus(JOB_ID));

        assertThat(exception.getMessage())
                .isEqualTo("JobExecution not found for this id: " + JOB_ID);
    }

    static Stream<Arguments> scenarios() {
        return Stream.of(
                Arguments.of("SMALL_EXCEL", JobsType.SMALL_EXCEL.getJobName()),
                Arguments.of("LARGE_EXCEL", JobsType.LARGE_EXCEL.getJobName())
        );
    }

}