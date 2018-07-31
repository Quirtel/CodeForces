import Foundation

//sourcery: RealmPersistable, additionalField = "gym", additionalFieldType = "Bool", additionalFieldDefaultValue = "false"
struct Contest: Codable {
    let id: Int
    let name: String
    let type: ContestType
    let phase: PhaseType
    let frozen: Bool
    let durationSeconds: Int
    let startTimeSeconds: Int?
    let relativeTimeSeconds: Int? //number of seconds after the start of the contest. Can be negative
    let preparedBy: String?
    let websiteUrl: String?
    let descr1ption: String?
    let difficulty: Int? //from 1 to 5. Why it is not enum?
    let kind: String?
    let icpcRegion: String?
    let country: String?
    let city: String?
    let season: String?
    
    enum CodingKeys: String, CodingKey {
        case descr1ption = "description"
        
        case id
        case name
        case type
        case phase
        case frozen
        case durationSeconds
        case startTimeSeconds
        case relativeTimeSeconds
        case preparedBy
        case websiteUrl
        case difficulty
        case kind
        case icpcRegion
        case country
        case city
        case season
    }
}
