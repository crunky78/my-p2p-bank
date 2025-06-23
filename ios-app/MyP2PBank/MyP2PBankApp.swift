//
//  MyP2PBankApp.swift
//  MyP2PBank
//
//  Created by 성현화 on 5/20/25.
//

import SwiftUI

@main
struct MyP2PBankApp: App {
    
    @StateObject private var sessionManager = SessionManager()
    
    
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(sessionManager) // 💡 앱 전체에 세션 공유
        }
    }
}
