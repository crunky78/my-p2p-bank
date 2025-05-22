import Foundation

struct BankUserResponse: Identifiable, Codable {
    let id: String
    let name: String
    let email: String
    let role: String
}
