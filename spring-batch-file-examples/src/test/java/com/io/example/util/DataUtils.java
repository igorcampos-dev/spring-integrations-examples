package com.io.example.util;

import org.springframework.batch.core.JobParameters;
import org.springframework.batch.core.JobParametersBuilder;

public class DataUtils {

    public static JobParameters getParameters(String filePath) {
        return new JobParametersBuilder()
                .addLong("time", System.currentTimeMillis())
                .addString("filePath", filePath)
                .toJobParameters();
    }

}