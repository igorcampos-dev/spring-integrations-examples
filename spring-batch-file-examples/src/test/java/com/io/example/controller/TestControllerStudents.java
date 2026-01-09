package com.io.example.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.io.example.dto.ExecutionDto;
import com.io.example.enums.JobsType;
import com.io.example.exception.BusinessException;
import com.io.example.exception.GlobalHandlerException;
import com.io.example.service.FileBatchService;
import org.instancio.Instancio;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.EnumSource;
import org.junit.jupiter.params.provider.ValueSource;
import org.springframework.batch.core.BatchStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.context.annotation.Import;
import org.springframework.http.MediaType;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.web.servlet.MockMvc;

import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(StudentController.class)
@DisplayName("TestController - Unit tests with MockMvc")
@Import(GlobalHandlerException.class)
class TestControllerStudents {

    private static final Long jobId = Instancio.create(Long.class);
    private static final ObjectMapper MAPPER = new ObjectMapper();

    @Autowired
    private MockMvc mockMvc;

    @MockitoBean
    private FileBatchService fileBatchService;

    @ParameterizedTest
    @ValueSource(strings = {
            "SMALL_EXCEL",
            "LARGE_EXCEL"
    })
    @DisplayName("POST /job/process → should return job ID when service runs successfully")
    void shouldReturnJobIdWhenProcessJobIsCalled(String jobName) throws Exception {
        var dto = new ExecutionDto(JobsType.valueOf(jobName));

        when(fileBatchService.runJob(dto)).thenReturn(jobId);

        mockMvc.perform(post("/job/process")
                .contentType(MediaType.APPLICATION_JSON)
                .content(MAPPER.writeValueAsString(dto))
                .accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(content().string(String.valueOf(jobId)));
    }

    @ParameterizedTest
    @EnumSource(BatchStatus.class)
    @DisplayName("GET /job/{jobId}/status → should return correct status for each BatchStatus")
    void shouldReturnJobStatusForAllBatchStatuses(BatchStatus status) throws Exception {

        when(fileBatchService.getJobStatus(jobId)).thenReturn(status);

        mockMvc.perform(get("/job/{jobId}/status", jobId)
                        .accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(content().string(status.name()));
    }

    @Test
    @DisplayName("GET /job/{jobId}/status → should return 400 when job ID is invalid")
    void shouldReturn400WhenJobIdIsInvalid() throws Exception {

        when(fileBatchService.getJobStatus(jobId))
                .thenThrow(new BusinessException("JobExecution not found for this id: " + jobId));

        mockMvc.perform(get("/job/{jobId}/status", jobId)
                .accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isBadRequest());
    }

}
