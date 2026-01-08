package com.io.example.dto;

import com.io.example.enums.JobsType;
import lombok.*;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ExecutionDto {
    private JobsType type;
}
