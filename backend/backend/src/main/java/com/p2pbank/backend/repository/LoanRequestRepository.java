package com.p2pbank.backend.repository;

import com.p2pbank.backend.domain.LoanRequest;
import com.p2pbank.backend.dto.LoanRequestDto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface LoanRequestRepository extends JpaRepository<LoanRequest, Integer> {

    @Query("select l from LoanRequest l where l.borrower.id=:userId")
    List<LoanRequest> findAllById(String userId);
}
