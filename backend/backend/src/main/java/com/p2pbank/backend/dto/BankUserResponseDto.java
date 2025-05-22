package com.p2pbank.backend.dto;

import com.p2pbank.backend.domain.BankUser;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class BankUserResponseDto {
    private String id;
    private String name;
    private String email;
    private String role;

    public static BankUserResponseDto from(BankUser user) {
        return BankUserResponseDto.builder()
                .id(user.getId())
                .name(user.getName())
                .email(user.getEmail())
                .role(user.getRole())
                .build();
    }
}
