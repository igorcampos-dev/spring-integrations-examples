package com.io.example.dataUsageBill.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class BillDto {
    private String orgName;
    private String depName;
    private String devName;
    private String groupName;
    private String dayStart;
    private String dayEnd;

    private Integer dtoOM;
    private Integer dtoON;
    private Integer dtoOL;
    private Integer dtoDL;
    private Integer dtoDN;
    private Integer dtoD;

    private Integer dtoOMamount;
    private Integer dtoONamount;
    private Integer dtoOLamount;
    private Integer dtoDLamount;
    private Integer dtoDNamount;
    private Integer dtoDamount;

    private Integer totalHrs;
    private Integer toltalAm;

}
