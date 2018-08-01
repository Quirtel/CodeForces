// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import RealmSwift


final class UserRealm: Object { 

    @objc dynamic var handle: String = "" // ""
    @objc dynamic var email: String? = nil // email ?? ""
    @objc dynamic var vkId: String? = nil // vkId ?? ""
    @objc dynamic var openId: String? = nil // openId ?? ""
    @objc dynamic var firstName: String? = nil // firstName ?? ""
    @objc dynamic var lastName: String? = nil // lastName ?? ""
    @objc dynamic var country: String? = nil // country ?? ""
    @objc dynamic var city: String? = nil // city ?? ""
    @objc dynamic var organization: String? = nil // organization ?? ""
    @objc dynamic var contribution: Int = 0 // Int(contribution)
    @objc dynamic var rank: String = "" // ""
    @objc dynamic var rating: Int = 0 // Int(rating)
    @objc dynamic var maxRank: String = "" // ""
    @objc dynamic var maxRating: Int = 0 // Int(maxRating)
    @objc dynamic var lastOnlineTimeSeconds: Int = 0 // Int(lastOnlineTimeSeconds)
    @objc dynamic var registrationTimeSeconds: Int = 0 // Int(registrationTimeSeconds)
    @objc dynamic var friendOfCount: Int = 0 // Int(friendOfCount)
    @objc dynamic var avatar: String = "" // ""
    @objc dynamic var titlePhoto: String = "" // ""

    

}

extension UserRealm: RealmObject {
    var model: User {
        
        
        
        return User(handle: handle, email: email, vkId: vkId, openId: openId, firstName: firstName, lastName: lastName, country: country, city: city, organization: organization, contribution: contribution, rank: rank, rating: rating, maxRank: maxRank, maxRating: maxRating, lastOnlineTimeSeconds: lastOnlineTimeSeconds, registrationTimeSeconds: registrationTimeSeconds, friendOfCount: friendOfCount, avatar: avatar, titlePhoto: titlePhoto)
    }

    convenience init(model: User) {
        self.init()
        
        self.handle = model.handle        
        self.email = model.email        
        self.vkId = model.vkId        
        self.openId = model.openId        
        self.firstName = model.firstName        
        self.lastName = model.lastName        
        self.country = model.country        
        self.city = model.city        
        self.organization = model.organization        
        self.contribution = model.contribution        
        self.rank = model.rank        
        self.rating = model.rating        
        self.maxRank = model.maxRank        
        self.maxRating = model.maxRating        
        self.lastOnlineTimeSeconds = model.lastOnlineTimeSeconds        
        self.registrationTimeSeconds = model.registrationTimeSeconds        
        self.friendOfCount = model.friendOfCount        
        self.avatar = model.avatar        
        self.titlePhoto = model.titlePhoto        
    }
}

extension User: RealmRepresentable {
    var persistenceObject: UserRealm {
        return UserRealm(model: self)
    }
}
