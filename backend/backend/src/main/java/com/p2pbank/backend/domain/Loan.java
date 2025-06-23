package com.p2pbank.backend.domain;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;

@Entity
@Table(name = "loan")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Loan {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // 대출자
    @ManyToOne
    @JoinColumn(name = "borrower_id", nullable = false)
    private BankUser borrower;

    // 대여자
    @ManyToOne
    @JoinColumn(name = "lender_id", nullable = false)
    private BankUser lender;

    // 금액
    @Column(nullable = false)
    private Long amount;

    // 이자율 (예: 5.5%)
    @Column(nullable = false)
    private Double interestRate;

    // 대출 시작일
    @Column(nullable = false)
    private LocalDate startedAt;

    // 상환 예정일
    @Column(nullable = false)
    private LocalDate dueAt;

    // 진행 상태
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private LoanStatus status;

    // 메모 (선택)
    private String note;
}
