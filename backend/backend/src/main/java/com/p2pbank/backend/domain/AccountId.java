package com.p2pbank.backend.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.*;

import java.io.Serializable;

@Embeddable
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
public class AccountId implements Serializable {

    private String accountNumber;  // 계좌번호

    @Column(length = 50)
    private String userId;         // User의 ID (FK)
}

