package com.p2pbank.backend.domain;

public enum LoanRequestStatus {
    REQUESTED,          //요청
    APPROVED,           //승인
    IN_PROGRESS,        //진행중
    COMPLETED,          //완료
    OVERDUE             //연체
}
