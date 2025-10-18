package com.io.example.dbReader.listener;

import lombok.extern.slf4j.Slf4j;
import org.springframework.batch.core.ExitStatus;
import org.springframework.batch.core.StepExecution;
import org.springframework.batch.core.StepExecutionListener;

@Slf4j
public class LoggingStepListener implements StepExecutionListener {

    @Override
    public void beforeStep(StepExecution stepExecution) {
        log.info("______________ STEP STARTING | StepName: {} | Read count: {} ______________",
                stepExecution.getStepName(),
                stepExecution.getReadCount());
    }

    @Override
    public ExitStatus afterStep(StepExecution stepExecution) {
        log.info("______________ STEP FINISHED | StepName: {} | Read count: {} | Write count: {} ______________",
                stepExecution.getStepName(),
                stepExecution.getReadCount(),
                stepExecution.getWriteCount());
        return stepExecution.getExitStatus();
    }

}
