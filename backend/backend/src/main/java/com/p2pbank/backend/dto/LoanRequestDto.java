package com.p2pbank.backend.dto;

import com.p2pbank.backend.domain.LoanRequest;
import com.p2pbank.backend.domain.LoanRequestStatus;
import lombok.*;

import java.time.LocalDate;

@Data
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class LoanRequestDto {
    private String borrowerId;
    private String lenderId;
    private Long amount;
    private LoanRequestStatus status;
    private Double interestRate;
    private LocalDate startedAt;
    private LocalDate dueAt;
    private String note;

}
