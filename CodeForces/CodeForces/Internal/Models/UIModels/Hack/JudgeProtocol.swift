import Foundation

//sourcery: RealmPersistable
struct JudgeProtocol: Codable {
    let manual: Bool
    let protocolDescription: String
    let verdictDescription: String
}

private extension JudgeProtocol {
    enum CodingKeys: String, CodingKey {
        case protocolDescription = "protocol"
        case verdictDescription = "verdict"
        
        case manual
    }
}

extension JudgeProtocol {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        protocolDescription = try values.decode(String.self, forKey: .protocolDescription)
        verdictDescription = try values.decode(String.self, forKey: .verdictDescription)
        
        let stringedManual = try values.decode(String.self, forKey: .manual)
        manual = stringedManual == "true" ? true : false
    }
}
