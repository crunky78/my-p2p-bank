package com.p2pbank.backend.controller;

import com.p2pbank.backend.dto.BankUserRequestDto;
import com.p2pbank.backend.service.BankUserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/bank-users")
@RequiredArgsConstructor
public class BankUserController {
    private final BankUserService bankUserService;

    @PostMapping
    public ResponseEntity<String> register(@RequestBody BankUserRequestDto dto){
        bankUserService.register(dto);
        return ResponseEntity.ok("회원가입 완료");
    }
}
