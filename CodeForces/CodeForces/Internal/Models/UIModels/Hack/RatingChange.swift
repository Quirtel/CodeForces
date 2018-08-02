import Foundation

//sourcery: RealmPersistable
struct RatingChange: Codable {
    let contestId: Int
    let contestName: String
    let handle: String
    let rank: Int
    let ratingUpdateTimeSeconds: Int
    let oldRating: Int
    let rating: Int
    
    enum CodingKeys: String, CodingKey {
        case rating = "newRating"
        
        case contestId
        case contestName
        case handle
        case rank
        case ratingUpdateTimeSeconds
        case oldRating
    }
}
