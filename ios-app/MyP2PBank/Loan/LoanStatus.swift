//
//  LoanStatus.swift
//  MyP2PBank
//
//  Created by 성현화 on 6/23/25.
//

// 대출 상태 Enum
enum LoanStatus: String, Codable {
    case requested = "REQUESTED"
    case approved = "APPROVED"
    case inProgress = "IN_PROGRESS"
    case completed = "COMPLETED"
    case overdue = "OVERDUE"
}

extension LoanStatus {
    var displayText: String {
            switch self {
            case .requested: return "요청됨"
            case .approved:  return "승인됨"
            case .inProgress:  return "진행중"
            case .completed:    return "상환 완료"
            case .overdue:      return "연체됨"
            }
        }
}
