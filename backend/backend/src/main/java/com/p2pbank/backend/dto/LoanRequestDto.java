package com.p2pbank.backend.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class LoanRequestDto {
    private Long loanRequestId;
    private String borrowerId;
    private Long amount;
    private BigDecimal interestRate;
    private int termMonths;
    private String status;
    private String note;
}
