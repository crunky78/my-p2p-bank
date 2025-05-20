package com.p2pbank.backend.domain;

import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity                                 // 🟢 이 클래스는 JPA에서 DB 테이블과 매핑되는 '엔티티'임을 의미
@Table(name = "loan_request")          // 🟢 DB 테이블 이름을 명시적으로 지정 (생략하면 클래스명 기반 자동 생성)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class LoanRequest {

    @Id                                 // 🟢 이 필드는 테이블의 '기본 키(PK)'임을 나타냄
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long loanRequestId;         // 기본키 (AUTO_INCREMENT)

    @Column(nullable = false, length = 50)
    private String borrowerId;          // BankUser의 ID. FK 연결은 나중에 ManyToOne으로도 가능

    @Column(nullable = false)
    private Long amount;                // 대출 금액

    @Column(precision = 5, scale = 2)
    private BigDecimal interestRate;


    @Column(nullable = false)
    private Integer termMonths;         // 대출 기간 (개월 수)

    @Column(nullable = false, length = 20)
    private String status = "PENDING";  // 신청 상태 (기본값: PENDING)

    @Column(columnDefinition = "TEXT")
    private String note;                // 메모 (선택 사항)

    private LocalDateTime createdAt;    // 생성일
    private LocalDateTime updatedAt;    // 수정일

    @PrePersist                         // 🟢 엔티티가 처음 저장되기 전 자동 실행되는 메서드
    public void onCreate() {
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }

    @PreUpdate                          // 🟢 엔티티가 업데이트되기 전 자동 실행되는 메서드
    public void onUpdate() {
        this.updatedAt = LocalDateTime.now();
    }
}
