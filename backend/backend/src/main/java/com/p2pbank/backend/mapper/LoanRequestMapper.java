package com.p2pbank.backend.mapper;

import com.p2pbank.backend.domain.LoanRequest;
import com.p2pbank.backend.dto.LoanRequestDto;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import java.util.List;

@Mapper(componentModel = "spring")
public interface LoanRequestMapper {

    @Mapping(source = "borrower.id", target = "borrowerId")
    @Mapping(source = "lender.id", target = "lenderId")
    LoanRequestDto toDto(LoanRequest loanRequest);

    LoanRequest toEntity(LoanRequestDto loanRequestDto);

    @Mapping(source = "borrower.id", target = "borrowerId")
    @Mapping(source = "lender.id", target = "lenderId")
    List<LoanRequestDto> toDto(List<LoanRequest> loanRequests);
}
