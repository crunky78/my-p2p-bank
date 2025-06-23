
import SwiftUI

struct LoanRequestListView: View {
    @StateObject private var viewModel = LoanRequestViewModel()
    @EnvironmentObject var sessionManager: SessionManager
    
    @State private var borrowerId: String = ""

    var body: some View {
        VStack {
            Text("📑 대출 요청 내역")
                .font(.title)
                .padding()

            if viewModel.loanRequests.isEmpty {
                ProgressView("불러오는 중...")
                    .onAppear {
                        if let user = sessionManager.currentUser{
                            viewModel.fetchLoanRequest(for: user.id)
                        }else{
                            print("로그인한 사용자가 없습니다.")
                        }
                        
                    }
            } else {
                List(viewModel.loanRequests) { request in
                    VStack(alignment: .leading, spacing: 6) {
                        Text("대상자: \(request.lenderId)")
                            .font(.headline)
                        Text("요청 금액: \(request.amount.formatted())원")
                        Text("이자율: \(request.interestRate)%")
                        Text("기간: \(request.startedAt) ~ \(request.dueAt)")
                        if !request.note.isEmpty {
                            Text("메모: \(request.note)")
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
        }
    }
}
