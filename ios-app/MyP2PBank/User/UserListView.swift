import SwiftUI

struct UserListView: View {
    @ObservedObject var userService = UserService()
    @Binding var selectedUser: BankUserResponse?

    @State private var users: [BankUserResponse] = []
    @State private var isLoading = true
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        List(users){
            user in
            Button{
                selectedUser = user
                dismiss()
            }label: {
                VStack(alignment: .leading){
                    Text(user.name)
                        .font(.headline)
                    Text(user.email)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
        }.navigationTitle("사용자 선택")
            .onAppear{
                fetchUsers()
            }
    }
    
    func fetchUsers(){
        guard let url = URL(string: "\(ConfigManager.shared.config?.baseURL ?? "")/bank-users/users") else {
            print("❌ URL 생성 실패")
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
            
            do{
                let decoded = try JSONDecoder().decode([BankUserResponse].self, from: data)
                DispatchQueue.main.async {
                    self.users = decoded
                    self.isLoading = false
                }
            }catch{
                print("❌ JSON 파싱 오류: \(error.localizedDescription)")
                if let raw = String(data: data, encoding:.utf8){
                    print("응답 원본 : \n\(raw)")
                }
            }
        }.resume()
        
        
    }
}
