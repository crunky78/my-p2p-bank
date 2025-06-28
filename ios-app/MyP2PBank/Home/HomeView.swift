import SwiftUI

struct HomeView: View {
    @EnvironmentObject var sessionManager: SessionManager

    @State private var goToLoanRequest = false
    @State private var goToLoanList = false
    @State private var goToLogin = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                // 앱 타이틀
                Text("Finzy")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 40)
                    .foregroundColor(.blue)

                // 요약 정보 카드
                HStack(spacing: 20) {
                    SummaryCard(title: "상환 예정 금액", amount: "₩1,200,000")
                    SummaryCard(title: "상환 받을 금액", amount: "₩850,000")
                }
                .padding(.horizontal)

                // 주요 버튼들
                VStack(spacing: 16) {
                    ActionButton(title: "📥 대출 요청", color: Color.blue.opacity(0.8)) {
                        goToLoanRequest = true
                    }
                    ActionButton(title: "💸 상환하기", color: Color.blue.opacity(0.6)) {
                        // 추후 구현
                    }
                    ActionButton(title: "🕒 연장 요청", color: Color.blue.opacity(0.4)) {
                        // 추후 구현
                    }
                    ActionButton(title: "📑 대출 내역", color: Color.blue.opacity(0.5)) {
                        goToLoanList = true
                    }
                }

                Spacer()

                // NavigationLinks
                NavigationLink(destination: LoanRequestView(), isActive: $goToLoanRequest) {
                    EmptyView()
                }

                NavigationLink(destination: LoanRequestListView(), isActive: $goToLoanList) {
                    EmptyView()
                }
            }
            .padding()
            .background(Color.white)
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                // 사용자 이름 표시 (왼쪽)
                ToolbarItem(placement: .navigationBarLeading) {
                    if let user = sessionManager.currentUser {
                        Text("\(user.name)님 👋")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }

                // 로그아웃 버튼 (오른쪽)
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        sessionManager.logout()
                    }) {
                        Image(systemName: "rectangle.portrait.and.arrow.forward")
                            .foregroundColor(.blue)
                            .imageScale(.large)
                    }
                    .accessibilityLabel("로그아웃")
                    
                }
            }
        }
    }
}

struct SummaryCard: View {
    let title: String
    let amount: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundColor(.gray)
            Text(amount)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.black)
        }
        .padding()
        .frame(width: 160, height: 100)
        .background(Color(UIColor.systemGray6))
        .cornerRadius(12)
        .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
    }
}

struct ActionButton: View {
    let title: String
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding()
                .background(color)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .padding(.horizontal)
    }
}
