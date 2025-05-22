//
//  User.swift
//  MyP2PBank
//
//  Created by 성현화 on 5/21/25.
//

import Foundation

struct BankUser: Codable, Identifiable {
    let id: String
    let name: String
    let email: String
    let role: String
}

