package com.p2pbank.backend.service;

import com.p2pbank.backend.auth.JwtUtil;
import com.p2pbank.backend.domain.BankUser;
import com.p2pbank.backend.dto.LoginRequestDto;
import com.p2pbank.backend.dto.SignupRequestDto;
import com.p2pbank.backend.repository.BankUserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AuthService {
    private final BankUserRepository bankUserRepository;
    private final BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder();
    private final JwtUtil jwtUtil;

    public void signup(SignupRequestDto dto) throws IllegalAccessException {
        if(bankUserRepository.existsById(dto.getId())){
            throw new IllegalAccessException("이미 존재하는 사용자입니다.");
        }

        BankUser user = BankUser.builder()
                .id(dto.getId())
                .passwd(bCryptPasswordEncoder.encode(dto.getPasswd()))
                .name(dto.getName())
                .email(dto.getEmail())
                .role(dto.getRole())
                .build();

        bankUserRepository.save(user);
    }

    public String login(LoginRequestDto dto){
        return bankUserRepository.findById(dto.getId())
                .filter(user -> new BCryptPasswordEncoder().matches(dto.getPasswd(), user.getPasswd()))
                .map(user -> jwtUtil.generateToken(user.getId())) // ✅ 로그인 성공 → 토큰 발급
                .orElse(null);
    }
}
