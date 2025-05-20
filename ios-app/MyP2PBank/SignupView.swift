import SwiftUI

struct SignupView: View {
    @State private var id: String = ""
    @State private var password: String = ""
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var role: String = ""
    @State private var signupResult: String?
    
    // 🔹 선택 가능한 역할 목록
    let roles = ["borrower"]

    var body: some View {
        VStack(spacing: 20) {
            Text("MyP2PBank 회원가입")
                .font(.title)
                .bold()

            TextField("아이디", text: $id)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            SecureField("비밀번호", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            TextField("이름", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            TextField("이메일", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            // 🔹 역할 선택 드롭다운
            Picker("역할 선택", selection: $role) {
                ForEach(roles, id: \.self) { role in
                    Text(role.capitalized).tag(role)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding(.horizontal)

            Button(action: {
                signup()
            }) {
                Text("회원가입")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .padding(.horizontal)
            }

            if let result = signupResult {
                Text(result)
                    .foregroundColor(.gray)
                    .padding(.top, 10)
            }

            Spacer()
        }
        .padding()
    }

    func signup() {
        guard let url = URL(string: "http://192.168.68.77:8080/auth/signup") else {
            signupResult = "URL이 유효하지 않아요."
            return
        }

        let signupData = [
            "id": id,
            "passwd": password,
            "name": name,
            "email": email,
            "role": role
        ]

        guard let jsonData = try? JSONSerialization.data(withJSONObject: signupData) else {
            signupResult = "데이터 생성 실패"
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                signupResult = "오류: \(error.localizedDescription)"
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                DispatchQueue.main.async {
                    if httpResponse.statusCode == 200 {
                        signupResult = "회원가입 성공!"
                    } else {
                        signupResult = "회원가입 실패 (코드: \(httpResponse.statusCode))"
                    }
                }
            }
        }.resume()
    }
}
