import Foundation

struct ContestListRequest: Codable {
    let gym: Bool?
    
    init(gym: Bool? = nil) {
        self.gym = gym
    }
}
