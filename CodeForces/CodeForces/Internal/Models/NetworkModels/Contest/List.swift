import Foundation

struct ContestListRequest: Codable {
    let gym: Bool
    
    init(gym: Bool = false) {
        self.gym = gym
    }
}
