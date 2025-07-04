package com.p2pbank.backend.domain;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "loan_request")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class LoanRequest {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // 요청자 (돈을 빌리려는 사람)
    @ManyToOne
    @JoinColumn(name = "borrower_id", nullable = false)
    private BankUser borrower;

    // 상대방 (돈을 빌려주는 대상)
    @ManyToOne
    @JoinColumn(name = "lender_id", nullable = false)
    private BankUser lender;

    // 대출 금액
    @Column(nullable = false)
    private Long amount;

    // 이자율 (예: 4.5%)
    @Column(nullable = false)
    private Double interestRate;

    @Column(nullable = false)
    private LocalDate startedAt;

    @Column(nullable = false)
    private LocalDate dueAt;

    // 요청 상태 (요청됨, 수락됨, 거절됨 등)
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private LoanRequestStatus status;

    // 요청 메모
    private String note;

    // 요청 시간
    @Column(nullable = false)
    private LocalDateTime createdAt;
}
