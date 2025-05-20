package com.p2pbank.backend.dto;


import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BankUserRequestDto {
    private String id;
    private String passwd;
    private String name;
    private String email;
    private String role;
}
