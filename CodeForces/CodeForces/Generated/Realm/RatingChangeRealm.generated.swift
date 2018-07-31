// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import RealmSwift


final class RatingChangeRealm: Object { 
    @objc dynamic var contestId: Int = 0 
    @objc dynamic var contestName: String = "" 
    @objc dynamic var handle: String = "" 
    @objc dynamic var rank: Int = 0 
    @objc dynamic var ratingUpdateTimeSeconds: Int = 0 
    @objc dynamic var oldRating: Int = 0 
    @objc dynamic var newRating: Int = 0 

}

extension RatingChangeRealm: RealmObject {
    var model: RatingChange {
        
        
        
        return RatingChange(contestId: contestId, contestName: contestName, handle: handle, rank: rank, ratingUpdateTimeSeconds: ratingUpdateTimeSeconds, oldRating: oldRating, newRating: newRating)
    }

    convenience init(model: RatingChange) {
        self.init()
        
        self.contestId = model.contestId        
        self.contestName = model.contestName        
        self.handle = model.handle        
        self.rank = model.rank        
        self.ratingUpdateTimeSeconds = model.ratingUpdateTimeSeconds        
        self.oldRating = model.oldRating        
        self.newRating = model.newRating        
    }
}

extension RatingChange: RealmRepresentable {
    var persistenceObject: RatingChangeRealm {
        return RatingChangeRealm(model: self)
    }
}
