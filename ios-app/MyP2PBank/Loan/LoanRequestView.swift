import SwiftUI

struct LoanRequestView: View {
    @State private var selectedUser: BankUserResponse?
    @State private var amount = ""
    @State private var interestRate = ""

    var body: some View {
        NavigationStack {
            Form {
                // 대출 대상 선택
                Section {
                    NavigationLink(destination: UserListView(selectedUser: $selectedUser)) {
                        HStack {
                            Text("대출 대상")
                            Spacer()
                            Text(selectedUser?.name ?? "선택하기")
                                .foregroundColor(.blue)
                        }
                    }
                }

                // 대출 조건
                Section(header: Text("대출 조건")) {
                    TextField("금액 (₩)", text: $amount)
                        .keyboardType(.numberPad)
                        .disabled(selectedUser == nil)

                    TextField("이자율 (%)", text: $interestRate)
                        .keyboardType(.decimalPad)
                        .disabled(selectedUser == nil)
                }

                // 대출 요청 버튼
                Button("대출 요청하기") {
                    // 요청 처리
                }
                .disabled(selectedUser == nil)
            }
            .navigationTitle("대출 요청")
            .navigationBarTitleDisplayMode(.inline)

        
        }
    }
}
