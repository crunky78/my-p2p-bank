import SwiftUI

struct HomeView: View {
    @EnvironmentObject var sessionManager: SessionManager
    
    @State private var goToLoanRequest = false  // 대출 요청화면 이동 트리거 변수
    @State private var goToLoanList = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("HomeView")
            }
            .navigationBarTitle("MyP2PBank")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    if let user = sessionManager.currentUser {
                        Text("\(user.name)님 👤")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
        
        VStack(spacing: 30) {
            // 앱 제목
            Text("My P2P Bank")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 40)

            // 요약 정보 카드
            HStack(spacing: 20) {
                SummaryCard(title: "상환 예정 금액", amount: "₩1,200,000")
                SummaryCard(title: "상환 받을 금액", amount: "₩850,000")
            }
            .padding(.horizontal)

            // 주요 버튼들
            VStack(spacing: 20) {
                ActionButton(title: "📥 대출 요청", color: .blue){goToLoanRequest = true}
                ActionButton(title: "💸 상환하기", color: .green){}
                ActionButton(title: "🕒 연장 요청", color: .orange){}
                ActionButton(title: "📑 대출 내역", color: .purple){goToLoanList=true}
            }
            
            // ✅ NavigationLink는 hidden + 상태에 따라 이동
            NavigationLink(destination: LoanRequestView(), isActive:$goToLoanRequest ){
                EmptyView()
            }
            
            NavigationLink(destination: LoanRequestListView(),
                           isActive: $goToLoanList){
                EmptyView()
            }
            
            Spacer()
        }
        .background(Color(.systemGroupedBackground))
    }
}

struct SummaryCard: View {
    let title: String
    let amount: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .foregroundColor(.gray)
            Text(amount)
                .font(.title2)
                .fontWeight(.bold)
        }
        .padding()
        .frame(width: 160, height: 100)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 4)
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
