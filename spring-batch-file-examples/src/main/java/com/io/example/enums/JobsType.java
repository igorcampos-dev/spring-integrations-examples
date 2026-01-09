package com.io.example.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum JobsType {

    SMALL_EXCEL("smallExcelJob"),
    LARGE_EXCEL("largeExcelJob");

    private final String jobName;
}