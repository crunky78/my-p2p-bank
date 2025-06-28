//
//  LoanRequest.swift
//  MyP2PBank
//
//  Created by 성현화 on 6/22/25.
//

import Foundation

struct LoanRequest:Identifiable, Codable {
    
    let borrowerId: String  //대출 요청자 ID
    let lenderId: String    //대출해준 사용자 ID
    let amount: Int         //대출 비용
    let interestRate: Double    //이자율
    let status: LoanStatus
    let startedAt: String       //대출 시작일
    let dueAt: String       //대출 만기일
    let note: String    //메모
    
    let id = UUID()
}
