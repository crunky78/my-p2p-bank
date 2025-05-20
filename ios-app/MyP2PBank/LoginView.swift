import SwiftUI

struct LoginView: View {
    @State private var userId: String = ""
    @State private var password: String = ""
    @State private var loginMessage: String?
    @State private var alertShown = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("MyP2PBank 로그인")
                    .font(.title)
                    .bold()

                TextField("아이디", text: $userId)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                SecureField("비밀번호", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                Button(action: {
                    login()
                }) {
                    Text("로그인")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }

                if let result = loginMessage {
                    Text(result)
                        .foregroundColor(.gray)
                }

                // 👉 회원가입으로 이동하는 NavigationLink 추가
                NavigationLink(destination: SignupView()) {
                    Text("계정이 없으신가요? 회원가입")
                        .foregroundColor(.blue)
                        .underline()
                }
                .padding(.top, 10)

                Spacer()
            }
            .padding()
        }
        .alert("알림", isPresented: $alertShown) {
            Button("확인", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }

    }

    func login() {
        guard let url = URL(string: "http://192.168.68.77:8080/auth/login") else { return }

                let loginData = [
                    "id": userId,
                    "passwd": password
                ]

                guard let jsonData = try? JSONSerialization.data(withJSONObject: loginData) else { return }

                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = jsonData

                URLSession.shared.dataTask(with: request) { data, response, error in
                    if let error = error {
                        DispatchQueue.main.async {
                            loginMessage = "에러: \(error.localizedDescription)"
                        }
                        return
                    }

                    if let httpResponse = response as? HTTPURLResponse {
                        DispatchQueue.main.async {
                            if httpResponse.statusCode == 200 {
                                alertMessage = "로그인 성공!"
                                alertShown = true
                            } else {
                                loginMessage = "로그인 실패 (상태 코드: \(httpResponse.statusCode))"
                            }
                        }
                    }
                }.resume()
    }
    
    
}


