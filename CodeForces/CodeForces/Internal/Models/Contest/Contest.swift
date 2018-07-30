import Foundation

struct Contest: Codable {
    let id: Int
    let name: String
    let type: ContestType
    let phase: Phase
    let frozen: Bool
    let durationSeconds: Int
    let startTimeSeconds: Int?
    let relativeTimeSeconds: Int? //number of seconds after the start of the contest. Can be negative
    let preparedBy: String?
    let websiteUrl: String?
    let description: String?
    let difficulty: Int? //from 1 to 5. Why it is not enum?
    let kind: String?
    let icpcRegion: String?
    let country: String?
    let city: String?
    let season: String?
}
