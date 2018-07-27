import Foundation

struct JudgeProtocol: Codable {
    let manual: Bool
    let protocolDescription: String
    let verdictDescription: String
    
    enum CodingKeys: String, CodingKey {
        case protocolDescription = "protocol"
        case verdictDescription = "verdict"
        
        case manual
    }
}
