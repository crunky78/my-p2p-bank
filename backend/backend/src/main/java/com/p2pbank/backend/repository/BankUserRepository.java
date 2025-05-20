package com.p2pbank.backend.repository;

import com.p2pbank.backend.domain.BankUser;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BankUserRepository extends JpaRepository<BankUser, String> {
}
