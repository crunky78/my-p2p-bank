import Foundation

class SessionManager: ObservableObject {
    @Published var isLoggedIn: Bool = false //로그인 상태 체크
    @Published var currentUser: BankUserResponse? = nil //로그인한 사용자 정보 저장
    @Published var token: String? = nil
    
    func logout() {
        self.isLoggedIn = false
        self.currentUser = nil
        self.token = nil
    }
}
