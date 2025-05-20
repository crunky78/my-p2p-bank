package com.p2pbank.backend.service;

import com.p2pbank.backend.domain.LoanRequest;
import com.p2pbank.backend.dto.LoanRequestDto;
import com.p2pbank.backend.repository.LoanRequestRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class LoanRequestService {

    private final LoanRequestRepository loanRequestRepository;

    public void create(LoanRequestDto dto){

        LoanRequest loanRequest = LoanRequest.builder()
                .borrowerId(dto.getBorrowerId())
                .amount(dto.getAmount())
                .interestRate(dto.getInterestRate())
                .termMonths(dto.getTermMonths())
                .status("PENDING")
                .note(dto.getNote())
                .build();

        loanRequestRepository.save(loanRequest);
    }
}
