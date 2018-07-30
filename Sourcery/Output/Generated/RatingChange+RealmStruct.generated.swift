// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import RealmSwift
final class RatingChangeObject: Object {
    @objc dynamic var contestId: Int = 0
    @objc dynamic var contestName: String = ""
    @objc dynamic var handle: String = ""
    @objc dynamic var rank: Int = 0
    @objc dynamic var ratingUpdateTimeSeconds: Int = 0
    @objc dynamic var oldRating: Int = 0
    @objc dynamic var newRating: Int = 0
    override static func primaryKey() -> String? {
        return "id"
    }
}
extension RatingChange: RealmRepresentable {
    var realmObject: RatingChangeObject {
        let ratingChange = RatingChangeObject()
        ratingChange.contestId = contestId
        ratingChange.contestName = contestName
        ratingChange.handle = handle
        ratingChange.rank = rank
        ratingChange.ratingUpdateTimeSeconds = ratingUpdateTimeSeconds
        ratingChange.oldRating = oldRating
        ratingChange.newRating = newRating
        return ratingChange
    }
}
extension RatingChangeObject: StructRepresentable {
    var `struct`: RatingChange {
        return RatingChange(contestId: contestId, contestName: contestName, handle: handle, rank: rank, ratingUpdateTimeSeconds: ratingUpdateTimeSeconds, oldRating: oldRating, newRating: newRating)
    }
}
