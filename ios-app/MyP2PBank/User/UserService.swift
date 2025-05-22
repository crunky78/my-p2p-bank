import Foundation

class UserService: ObservableObject {
    @Published var users: [BankUserResponse] = []

    func fetchAllUsers() {
        guard let url = URL(string: "\(ConfigManager.shared.config?.baseURL ?? "")/users") else {
            print("❌ URL 오류")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("❌ 네트워크 오류: \(error)")
                return
            }

            guard let data = data else {
                print("❌ 응답 데이터 없음")
                return
            }

            do {
                let decodedUsers = try JSONDecoder().decode([BankUserResponse].self, from: data)
                DispatchQueue.main.async {
                    self.users = decodedUsers
                }
            } catch {
                print("❌ 디코딩 실패: \(error)")
            }
        }.resume()
    }
}
