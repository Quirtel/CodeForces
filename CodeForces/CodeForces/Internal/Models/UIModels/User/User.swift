import Foundation

//sourcery: RealmStruct
struct User: Codable {
    let handle: String
    let email: String?
    let vkId: String?
    let openId: String? //contact info
    let firstName: String?
    let lastName: String?
    let country: String?
    let city: String?
    let organization: String?
    let contribution: Int
    let rank: String
    let rating: Int
    let maxRank: String
    let maxRating: Int
    let lastOnlineTimeSeconds: Int //in unix format (seconds since Jan 01 1970.)
    let registrationTimeSeconds: Int
    let friendOfCount: Int
    let avatar: String
    let titlePhoto: String
}
