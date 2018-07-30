import Foundation

//sourcery: RealmStruct
struct RatingChange: Codable {
    let contestId: Int
    let contestName: String
    let handle: String
    let rank: Int
    let ratingUpdateTimeSeconds: Int
    let oldRating: Int
    let newRating: Int
}
