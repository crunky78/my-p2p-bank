//
//  MyP2PBankApp.swift
//  MyP2PBank
//
//  Created by 성현화 on 5/20/25.
//

import SwiftUI

@main
struct MyP2PBankApp: App {
    @StateObject var sessionManager = SessionManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(sessionManager)
        }
    }
}


