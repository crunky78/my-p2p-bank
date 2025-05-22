import SwiftUI

struct SignupView: View {
    @State private var id: String = ""
    @State private var password: String = ""
    @State private var email: String = ""
    @State private var name: String = ""
    @State private var role: String = "borrower"

    @State private var alertShown = false
    @State private var alertMessage = ""
    @State private var goToLogin = false   // 🔹 로그인 화면으로 이동 여부

    let roles = ["borrower"]

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("회원가입").font(.title).bold()

                TextField("아이디", text: $id)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                SecureField("비밀번호", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("이메일", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField ("이름", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Picker("역할 선택", selection: $role) {
                    ForEach(roles, id: \.self) {
                        Text($0.capitalized)
                    }
                }
                .pickerStyle(MenuPickerStyle())

                Button("회원가입") {
                    signup()
                }
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(8)

                // 🔹 NavigationLink로 로그인 화면 이동
                NavigationLink(destination: LoginView(), isActive: $goToLogin) {
                    EmptyView()
                }

                Spacer()
            }
            .padding()
            .alert("알림", isPresented: $alertShown) {
                Button("확인", role: .cancel) { }
            } message: {
                Text(alertMessage)
            }
        }
    }

    func signup() {
        guard let url = URL(string: "\(ConfigManager.shared.config?.baseURL ?? "")/auth/signup") else {
            alertMessage = "서버 주소 오류"
            alertShown = true
            return
        }

        let signupData: [String: Any] = [
            "id": id,
            "passwd": password,
            "email": email,
            "name": name,
            "role": role
        ]

        guard let jsonData = try? JSONSerialization.data(withJSONObject: signupData) else {
            alertMessage = "데이터 오류"
            alertShown = true
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    alertMessage = "에러: \(error.localizedDescription)"
                    alertShown = true
                    return
                }

                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        alertMessage = "회원가입 성공! 로그인 화면으로 이동합니다"
                        alertShown = true
                        // ✅ 1초 뒤 자동 이동
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            goToLogin = true
                        }
                    } else {
                        alertMessage = "회원가입 실패 (\(httpResponse.statusCode))"
                        alertShown = true
                    }
                }
            }
        }.resume()
    }
}
