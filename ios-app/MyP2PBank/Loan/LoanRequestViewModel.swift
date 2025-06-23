//
//  LoanRequestViewModel.swift
//  MyP2PBank
//
//  Created by 성현화 on 6/22/25.
//

import Foundation

class LoanRequestViewModel: ObservableObject {
    @Published var loanRequests: [LoanRequest] = []
    
    func fetchLoanRequest(for borrowerId: String) {
        guard let url = URL(string: "\(ConfigManager.shared.config?.baseURL ?? "")/loan/request/\(borrowerId)") else { return }

                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    guard let data = data, error == nil else { return }
                    
                    do {
                        let decoded = try JSONDecoder().decode([LoanRequest].self, from: data)
                        DispatchQueue.main.async {
                            self.loanRequests = decoded
                        }
                    } catch {
                        print("❌ Decoding error: \(error)")
                    }
                }
                task.resume()
    }
}
