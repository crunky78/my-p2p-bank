package com.p2pbank.backend.service;

import com.p2pbank.backend.domain.LoanRequest;
import com.p2pbank.backend.domain.LoanRequestStatus;
import com.p2pbank.backend.dto.LoanRequestDto;
import com.p2pbank.backend.mapper.LoanRequestMapper;
import com.p2pbank.backend.repository.BankUserRepository;
import com.p2pbank.backend.repository.LoanRequestRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class LoanRequestService {

    private final LoanRequestRepository loanRequestRepository;
    private final BankUserRepository userRepository;
    private final LoanRequestMapper loanRequestMapper;

    public void create(LoanRequestDto dto) {
        LoanRequest request = LoanRequest.builder()
                .borrower(userRepository.findById(dto.getBorrowerId()).orElseThrow())
                .lender(userRepository.findById(dto.getLenderId()).orElseThrow())
                .amount(dto.getAmount())
                .interestRate(dto.getInterestRate())
                .startedAt(dto.getStartedAt())
                .dueAt(dto.getDueAt())
                .note(dto.getNote())
                .status(LoanRequestStatus.REQUESTED)
                .createdAt(LocalDateTime.now())
                .build();

        loanRequestRepository.save(request);
    }

    public List<LoanRequestDto> getMyLoanRequestLists(String requestId) {
        List<LoanRequest> loanRequests =  loanRequestRepository.findAllById(requestId);
        return loanRequestMapper.toDto(loanRequests);
    }

}
