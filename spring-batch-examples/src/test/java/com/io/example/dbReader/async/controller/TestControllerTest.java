package com.io.example.dbReader.async.controller;

import com.io.example.dbReader.async.exception.BusinessException;
import com.io.example.dbReader.async.service.AsyncBatchService;
import org.instancio.Instancio;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.EnumSource;
import org.springframework.batch.core.BatchStatus;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.http.MediaType;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.beans.factory.annotation.Autowired;

import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@DisplayName("TestController - Unit tests with MockMvc")
@WebMvcTest(TestController.class)
class TestControllerTest {

    private static final Long jobId = Instancio.create(Long.class);

    @Autowired
    private MockMvc mockMvc;

    @MockitoBean
    private AsyncBatchService asyncBatchService;

    @Test
    @DisplayName("GET /job/process → should return job ID when service runs successfully")
    void shouldReturnJobIdWhenProcessJobIsCalled() throws Exception {

        when(asyncBatchService.runJob()).thenReturn(jobId);

        mockMvc.perform(get("/job/process")
                .accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(content().string(String.valueOf(jobId)));
    }

    @ParameterizedTest
    @EnumSource(BatchStatus.class)
    @DisplayName("GET /job/{jobId}/status → should return correct status for each BatchStatus")
    void shouldReturnJobStatusForAllBatchStatuses(BatchStatus status) throws Exception {

        when(asyncBatchService.getJobStatus(jobId)).thenReturn(status);

        mockMvc.perform(get("/job/{jobId}/status", jobId)
                        .accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(content().string(status.name()));
    }

    @Test
    @DisplayName("GET /job/{jobId}/status → should return 404 when job ID is invalid")
    void shouldReturn404WhenJobIdIsInvalid() throws Exception {

        when(asyncBatchService.getJobStatus(jobId))
                .thenThrow(new BusinessException("JobExecution not found for this id: " + jobId));

        mockMvc.perform(get("/job/{jobId}/status", jobId)
                .accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isBadRequest());
    }

}
