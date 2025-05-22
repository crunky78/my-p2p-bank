//
//  LoginResponse.swift
//  MyP2PBank
//
//  Created by 성현화 on 5/22/25.
//

import Foundation
struct LoginResponse: Codable {
    let token: String
    let user: BankUserResponse
}
