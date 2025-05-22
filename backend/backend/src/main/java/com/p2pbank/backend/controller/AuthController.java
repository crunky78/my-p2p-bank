package com.p2pbank.backend.controller;

import com.p2pbank.backend.dto.BankUserResponseDto;
import com.p2pbank.backend.dto.LoginRequestDto;
import com.p2pbank.backend.dto.LoginResponseDto;
import com.p2pbank.backend.dto.SignupRequestDto;
import com.p2pbank.backend.service.AuthService;
import com.p2pbank.backend.service.BankUserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/auth")
@RequiredArgsConstructor
public class AuthController {
    private final AuthService authService;
    private final BankUserService bankUserService;

    @PostMapping("/signup")
    public ResponseEntity<String> signup(@RequestBody SignupRequestDto dto) throws IllegalAccessException {
        authService.signup(dto);
        return ResponseEntity.ok("회원가입 성공");
    }

    @PostMapping("/login")
    public ResponseEntity<LoginResponseDto> login(@RequestBody LoginRequestDto dto) {
        //1.인증 처리
        String token = authService.login(dto);

        //2. 사용자 정보 조회(엔티티 -> dto 변환)
        BankUserResponseDto userDto = bankUserService.getBankUserDtoById(dto.getId());

        LoginResponseDto responseDto = new LoginResponseDto(token, userDto);
        return ResponseEntity.ok(responseDto);
    }

}
