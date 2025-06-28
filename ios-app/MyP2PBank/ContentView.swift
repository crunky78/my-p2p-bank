import SwiftUI

struct ContentView: View {
    @EnvironmentObject var sessionManager: SessionManager

    var body: some View {
        if sessionManager.isLoggedIn {
            HomeView()
        } else {
            LoginView()
        }
    }
}
