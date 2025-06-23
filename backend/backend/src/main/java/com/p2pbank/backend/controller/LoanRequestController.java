package com.p2pbank.backend.controller;

import com.p2pbank.backend.dto.LoanRequestDto;
import com.p2pbank.backend.service.LoanRequestService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/loan")
@RequiredArgsConstructor
public class LoanRequestController {

    private final LoanRequestService loanRequestService;

    //사용자가 대출 요청 함
    @PostMapping("/request")
    public ResponseEntity<String> requestLoan(@RequestBody LoanRequestDto dto) {
        loanRequestService.create(dto);
        return ResponseEntity.ok("대출요청 성공");
    }

    @GetMapping("/request/{uid}")
    public List<LoanRequestDto> getMyLoanRequests(@PathVariable String uid) {
        return loanRequestService.getMyLoanRequestLists(uid);
    }
}
