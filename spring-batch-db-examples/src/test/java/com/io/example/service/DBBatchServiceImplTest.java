package com.io.example.service;

import com.io.example.exception.BusinessException;
import com.io.example.service.impl.DBBatchServiceImpl;
import org.instancio.Instancio;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.batch.core.BatchStatus;
import org.springframework.batch.core.Job;
import org.springframework.batch.core.JobExecution;
import org.springframework.batch.core.JobParameters;
import org.springframework.batch.core.explore.JobExplorer;
import org.springframework.batch.core.launch.JobLauncher;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("Unit tests for AsyncBatchServiceImpl")
class DBBatchServiceImplTest {

    private static final Long jobId = Instancio.create(Long.class);

    @Mock
    private JobLauncher asyncJobLauncher;

    @Mock
    private Job batchJob;

    @Mock
    private JobExplorer jobExplorer;

    @InjectMocks
    private DBBatchServiceImpl batchService;

    @Test
    @DisplayName("Should run job successfully and return job execution id")
    void shouldRunJobSuccessfully() throws Exception {

        JobExecution jobExecutionMock = mock(JobExecution.class);
        when(jobExecutionMock.getId()).thenReturn(123L);
        when(asyncJobLauncher.run(eq(batchJob), any(JobParameters.class)))
                .thenReturn(jobExecutionMock);

        Long jobId = batchService.runJob();

        assertThat(jobId).isEqualTo(123L);
        verify(asyncJobLauncher).run(eq(batchJob), any(JobParameters.class));
    }

    @Test
    @DisplayName("Should throw BusinessException when job execution fails")
    void shouldThrowBusinessExceptionWhenJobFails() throws Exception {

        when(asyncJobLauncher.run(any(Job.class), any(JobParameters.class)))
                .thenThrow(new RuntimeException("Simulated error"));

        BusinessException exception = assertThrows(BusinessException.class,
                () -> batchService.runJob());

        assertThat(exception.getMessage()).isEqualTo("Simulated error");
    }

    @Test
    @DisplayName("Should return job status when job execution exists")
    void shouldReturnJobStatus() {
        JobExecution jobExecutionMock = mock(JobExecution.class);
        when(jobExecutionMock.getStatus()).thenReturn(BatchStatus.COMPLETED);
        when(jobExplorer.getJobExecution(jobId)).thenReturn(jobExecutionMock);

        BatchStatus status = batchService.getJobStatus(jobId);

        assertThat(status).isEqualTo(BatchStatus.COMPLETED);
        verify(jobExplorer).getJobExecution(jobId);
    }

    @Test
    @DisplayName("Should throw BusinessException when job execution not found")
    void shouldThrowBusinessExceptionWhenJobNotFound() {
        when(jobExplorer.getJobExecution(jobId)).thenReturn(null);

        BusinessException exception = assertThrows(BusinessException.class,
                () -> batchService.getJobStatus(jobId));

        assertThat(exception.getMessage())
                .isEqualTo("JobExecution not found for this id: " + jobId);
    }
}
