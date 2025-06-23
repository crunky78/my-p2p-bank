import UIKit

// 대출 상태 Enum
enum LoanStatus: String, Codable {
    case requested = "REQUESTED"
    case approved = "APPROVED"
    case inProgress = "IN_PROGRESS"
    case completed = "COMPLETED"
    case overdue = "OVERDUE"
}

// Loan 데이터 모델
struct Loan: Codable {
    let id: Int
    let amount: Double
    let interestRate: Double
    let startDate: String
    let endDate: String
    let status: LoanStatus
}

class LoanDetailViewController: UIViewController {
    
    // 예시: 대출 데이터
    var loan: Loan? {
        didSet {
            updateUI()
        }
    }
    
    // UI 요소
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchLoanData()
    }
    
    // API 호출 (URLSession 예시)
    func fetchLoanData() {
        guard let url = URL(string: "\(ConfigManager.shared.config?.baseURL ?? "")/loans/1") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        //request.addValue("Bearer \(yourJWTToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let data = data else { return }
            do {
                let loan = try JSONDecoder().decode(Loan.self, from: data)
                DispatchQueue.main.async {
                    self?.loan = loan
                }
            } catch {
                print("Error decoding loan: \(error)")
            }
        }.resume()
    }
    
    // 상태 업데이트
    func updateUI() {
        guard let loan = loan else { return }
        
        amountLabel.text = "\(loan.amount) 원"
        switch loan.status {
        case .requested:
            statusLabel.text = "대출 상태: 신청됨"
            statusLabel.textColor = .gray
        case .approved:
            statusLabel.text = "대출 상태: 승인됨"
            statusLabel.textColor = .blue
        case .inProgress:
            statusLabel.text = "대출 상태: 진행중"
            statusLabel.textColor = .green
        case .completed:
            statusLabel.text = "대출 상태: 상환 완료"
            statusLabel.textColor = .black
        case .overdue:
            statusLabel.text = "대출 상태: 연체"
            statusLabel.textColor = .red
            showOverdueAlert()
        }
    }
    
    // 연체 상태 경고
    func showOverdueAlert() {
        let alert = UIAlertController(title: "연체 상태", message: "현재 연체 상태입니다. 빠른 시일 내에 상환해주세요.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}
