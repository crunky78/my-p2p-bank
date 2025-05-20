package com.p2pbank.backend.service;

import com.p2pbank.backend.domain.BankUser;
import com.p2pbank.backend.dto.BankUserRequestDto;
import com.p2pbank.backend.repository.BankUserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class BankUserService {

    private final BankUserRepository bankUserRepository;

    public void register(BankUserRequestDto dto) {
        if (bankUserRepository.existsById(dto.getId())) {
            throw new IllegalArgumentException("이미 존재하는 사용자입니다.");
        }

        BankUser user = BankUser.builder()
                .id(dto.getId())
                .passwd(dto.getPasswd())
                .name(dto.getName())
                .email(dto.getEmail())
                .role(dto.getRole())
                .build();

        bankUserRepository.save(user);
    }

    public BankUser getBankUser(String id) {
        return bankUserRepository.findById(id).orElse(null);
    }
}
