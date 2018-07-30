// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import RealmSwift
final class UserObject: Object {
    @objc dynamic var handle: String = ""
    @objc dynamic var email: String? = nil
    @objc dynamic var vkId: String? = nil
    @objc dynamic var openId: String? = nil
    @objc dynamic var firstName: String? = nil
    @objc dynamic var lastName: String? = nil
    @objc dynamic var country: String? = nil
    @objc dynamic var city: String? = nil
    @objc dynamic var organization: String? = nil
    @objc dynamic var contribution: Int = 0
    @objc dynamic var rank: String = ""
    @objc dynamic var rating: Int = 0
    @objc dynamic var maxRank: String = ""
    @objc dynamic var maxRating: Int = 0
    @objc dynamic var lastOnlineTimeSeconds: Int = 0
    @objc dynamic var registrationTimeSeconds: Int = 0
    @objc dynamic var friendOfCount: Int = 0
    @objc dynamic var avatar: String = ""
    @objc dynamic var titlePhoto: String = ""
    override static func primaryKey() -> String? {
        return "id"
    }
}
extension User: RealmRepresentable {
    var realmObject: UserObject {
        let user = UserObject()
        user.handle = handle
        user.email = email
        user.vkId = vkId
        user.openId = openId
        user.firstName = firstName
        user.lastName = lastName
        user.country = country
        user.city = city
        user.organization = organization
        user.contribution = contribution
        user.rank = rank
        user.rating = rating
        user.maxRank = maxRank
        user.maxRating = maxRating
        user.lastOnlineTimeSeconds = lastOnlineTimeSeconds
        user.registrationTimeSeconds = registrationTimeSeconds
        user.friendOfCount = friendOfCount
        user.avatar = avatar
        user.titlePhoto = titlePhoto
        return user
    }
}
extension UserObject: StructRepresentable {
    var `struct`: User {
        return User(handle: handle, email: email, vkId: vkId, openId: openId, firstName: firstName, lastName: lastName, country: country, city: city, organization: organization, contribution: contribution, rank: rank, rating: rating, maxRank: maxRank, maxRating: maxRating, lastOnlineTimeSeconds: lastOnlineTimeSeconds, registrationTimeSeconds: registrationTimeSeconds, friendOfCount: friendOfCount, avatar: avatar, titlePhoto: titlePhoto)
    }
}
