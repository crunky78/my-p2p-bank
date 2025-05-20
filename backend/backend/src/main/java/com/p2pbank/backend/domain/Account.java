package com.p2pbank.backend.domain;


import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "account")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Account {

    @EmbeddedId
    private AccountId id;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("userId")
    @JoinColumn(name = "id", nullable = false)
    private BankUser user;

    @Column(nullable = false, length = 50)
    private String name;

    @Column(nullable = false)
    private int balance;

    private LocalDateTime createDate;
    private LocalDateTime modifyDate;

    @PrePersist
    public void onCreate() {
        this.createDate = LocalDateTime.now();
        this.modifyDate = LocalDateTime.now();
    }

    @PreUpdate
    public void onUpdate() {
        this.modifyDate = LocalDateTime.now();
    }
}
