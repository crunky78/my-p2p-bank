package com.p2pbank.backend.dto;

import com.p2pbank.backend.domain.LoanStatus;
import lombok.Builder;
import lombok.Data;

import java.time.LocalDate;

@Data
@Builder
public class LoanResponseDto {

    private Long id;
    private String borrowerId;
    private String lenderId;
    private Long amount;
    private Double interestRate;
    private LocalDate startedAt;
    private LocalDate dueAt;
    private LoanStatus status;
    private String note;
}
