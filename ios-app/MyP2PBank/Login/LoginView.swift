import SwiftUI
import Foundation

struct LoginView: View {
    @EnvironmentObject var sessionManager: SessionManager
    
    @State private var userId: String = "hyunhwa"//임시로 hyunhwa 세팅
    @State private var password: String = ""
    @State private var loginMessage: String?
    @State private var alertShown = false
    @State private var alertMessage = ""
    
    @State private var goToHome = false   // 🔹 홈화면으로 이동 여부
    
    var body: some View {
        
        NavigationStack {
            VStack(spacing: 20) {
                
                // 🔹 로고 이미지
               Image("finzyLogo")
                   .resizable()
                   .scaledToFit()
                   .frame(width: 150, height: 150)
                   .padding(.top, 30)

                TextField("아이디", text: $userId)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                SecureField("비밀번호", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                Button(action: {
                    loadConfig() //ip 확인용
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
                
                // 🔹 NavigationLink로 로그인 화면 이동
                NavigationLink(destination: HomeView(), isActive: $goToHome) {
                    EmptyView()
                }

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
        guard let url = URL(string: "\(ConfigManager.shared.config?.baseURL ?? "")/auth/login") else { return }
        //guard let url = URL(string: "http://192.168.1.70:8080/auth/login") else { return }
        
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
                        guard let data = data else {
                            loginMessage = "로그인 성공했지만 사용자 정보 없음"
                            return
                        }

                        // ✅ 응답 디코딩
                        if let decodedUser = try? JSONDecoder().decode(LoginResponse.self, from: data) {
                            sessionManager.currentUser = decodedUser.user
                            sessionManager.isLoggedIn = true
                            sessionManager.token = decodedUser.token 
                            
                            alertMessage = "로그인 성공!"
                            alertShown = true
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                goToHome = true
                            }
                        } else {
                            if let rawJSON = String(data: data, encoding: .utf8) {
                                print("📦 응답 JSON:\n\(rawJSON)")
                            }
                            loginMessage = "사용자 정보 디코딩 실패"
                        }
                    } else {
                        loginMessage = "로그인 실패 (상태 코드: \(httpResponse.statusCode))"
                    }
                }
            }
        }.resume()
    }
    
    

    func loadConfig() {
        if let url = Bundle.main.url(forResource: "config", withExtension: "json") {
            print("✅ config.json 위치 확인됨: \(url)")
        } else {
            print("❌ config.json을 찾을 수 없습니다.")
        }
    }
    
}


