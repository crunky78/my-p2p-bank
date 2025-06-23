import SwiftUI

struct LoanRequestView: View {
    @State private var selectedUser: BankUserResponse?
    @EnvironmentObject var sessionManager:SessionManager
    @State private var amount = ""
    @State private var interestRate = ""
    
    @State private var startDate = Date()
    @State private var endDate = Calendar.current.date(byAdding: .month, value: 6, to: Date())!
    
    @State private var alertShown = false
    @State private var alertMessage = "알림 메시지입니다."
    
    @State private var goToHome = false

    var body: some View {
        NavigationStack {
            Form {
                // 🔹 대출 대상 선택
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

                
                Section(header: Text("대출 조건")) {
                    TextField("금액 (₩)", text: $amount)
                        .keyboardType(.numberPad)
                        .disabled(selectedUser == nil)

                    TextField("이자율 (%)", text: $interestRate)
                        .keyboardType(.decimalPad)
                        .disabled(selectedUser == nil)

                    // 🔹 시작일 선택
                    DatePicker("대출 시작일", selection: $startDate, displayedComponents: .date)
                        .disabled(selectedUser == nil)

                    // 🔹 종료일 선택
                    DatePicker("상환 예정일", selection: $endDate, in: startDate..., displayedComponents: .date)
                        .disabled(selectedUser == nil)
                }

                // 🔹 이쁜 대출 요청 버튼
                Section {
                    Button(action: {
                        requestLoan()
                    }) {
                        HStack {
                            Spacer()
                            Text("📥 대출 요청하기")
                                .foregroundColor(.white)
                                .bold()
                            Spacer()
                        }
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                    }
                    .disabled(selectedUser == nil)
                }
            }
            .navigationTitle("대출 요청")
            .navigationBarTitleDisplayMode(.inline)
            
            // 🔹 NavigationLink로 로그인 화면 이동
            NavigationLink(destination: HomeView(), isActive: $goToHome) {
                EmptyView()
            }
            
            .alert("알림", isPresented: $alertShown) {
                Button("확인", role: .cancel) { }
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    func requestLoan() {
        guard let url = URL(string: "\(ConfigManager.shared.config?.baseURL ?? "")/loan/request") else { return }

        guard let borrowerId = sessionManager.currentUser?.id,
              let lenderId = selectedUser?.id,
              let amount = Int(self.amount),
              let interest = Double(self.interestRate) else {
            print("⚠️ 필수 데이터 누락")
            return
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let requestData: [String: Any] = [
            "borrowerId": borrowerId,
            "lenderId": lenderId,
            "amount": amount,
            "interestRate": interest,
            "startedAt": dateFormatter.string(from: startDate),
            "dueAt": dateFormatter.string(from: endDate),
            "note": ""
        ]


        guard let jsonData = try? JSONSerialization.data(withJSONObject: requestData) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    //alert( "에러: \(error.localizedDescription)")
                   
                }
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    alertMessage = "대출요청 성공! 홈 화면으로 이동합니다"
                    alertShown = true
                    // ✅ 1초 뒤 자동 이동
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        goToHome = true
                    }
                } else {
                    alertMessage = "대출요청 실패 (\(httpResponse.statusCode))"
                    alertShown = true
                }
            }
        }.resume()
    }
}
