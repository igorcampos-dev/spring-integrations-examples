package com.io.example.job;

import com.io.example.model.dto.TestDto;
import com.io.example.model.entity.TestEntity;
import com.io.example.service.TestService;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.batch.core.*;
import org.springframework.batch.core.launch.JobLauncher;
import org.springframework.batch.item.database.JdbcPagingItemReader;
import org.springframework.batch.test.context.SpringBatchTest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.bean.override.mockito.MockitoBean;

import static com.io.example.util.DataUtils.*;
import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@SpringBootTest
@SpringBatchTest
@ActiveProfiles("test")
@DisplayName("BatchJob - Integration test with real Job execution")
class BatchJobIntegrationTest {

    @Autowired
    private JobLauncher jobLauncher;

    @Autowired
    private Job batchJob;

    @MockitoBean("asyncReader")
    private JdbcPagingItemReader<TestEntity> asyncReader;

    @MockitoBean
    private TestService testService;

    @Test
    @DisplayName("Should execute batchJob and complete successfully with mocked reader")
    void shouldExecuteJobSuccessfully() throws Exception {

        configJdbcPagingItemReaderMock(asyncReader);

        JobExecution execution = jobLauncher.run(batchJob, getParameters());

        assertThat(execution.getStatus()).isEqualTo(BatchStatus.COMPLETED);
        verify(testService, times(5)).print(any(TestDto.class));

    }

    @Test
    @DisplayName("Should fail executing batchJob when reader throws exception")
    void shouldFailJobWhenReaderThrowsException() throws Exception {

        when(asyncReader.read())
                .thenThrow(new RuntimeException("Simulated reader failure"));

        JobExecution execution = jobLauncher.run(batchJob, getParameters());

        assertThat(execution.getStatus()).isNotEqualTo(BatchStatus.COMPLETED);
        assertThat(execution.getStatus()).isEqualTo(BatchStatus.FAILED);

        verify(testService, never()).print(any(TestDto.class));

    }

    @Test
    @DisplayName("Should execute batchJob and complete successfully when reader has no data")
    void shouldCompleteJobWithNoData() throws Exception {

        when(asyncReader.read()).thenReturn(null);

        JobExecution execution = jobLauncher.run(batchJob, getParameters());

        assertThat(execution.getStatus()).isEqualTo(BatchStatus.COMPLETED);

        verify(testService, never()).print(any(TestDto.class));

    }

}
