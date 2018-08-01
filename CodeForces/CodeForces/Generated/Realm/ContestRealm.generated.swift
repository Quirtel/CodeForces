// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import RealmSwift


final class ContestRealm: Object { 
	@objc dynamic var gym: Bool = false


    @objc dynamic var id: Int = 0 // Int(id)
    @objc dynamic var name: String = "" // ""
    @objc dynamic var type: String! // type
    @objc dynamic var phase: String! // phase
    @objc dynamic var frozen: Bool = false // ""
    @objc dynamic var durationSeconds: Int = 0 // Int(durationSeconds) 
    let startTimeSeconds = RealmOptional<Int>() // startTimeSeconds.value ?? 0 
    let relativeTimeSeconds = RealmOptional<Int>() // relativeTimeSeconds.value ?? 0
    @objc dynamic var preparedBy: String? = nil // preparedBy ?? ""
    @objc dynamic var websiteUrl: String? = nil // websiteUrl ?? ""
    @objc dynamic var descr1ption: String? = nil // descr1ption ?? "" 
    let difficulty = RealmOptional<Int>() // difficulty.value ?? 0
    @objc dynamic var kind: String? = nil // kind ?? ""
    @objc dynamic var icpcRegion: String? = nil // icpcRegion ?? ""
    @objc dynamic var country: String? = nil // country ?? ""
    @objc dynamic var city: String? = nil // city ?? ""
    @objc dynamic var season: String? = nil // season ?? ""

    
        override static func primaryKey() -> String? {
            return "id"
        }
        

}

extension ContestRealm: RealmObject {
    var model: Contest {
        guard let typeValue = type, let type = ContestType(rawValue: typeValue), let phaseValue = phase, let phase = PhaseType(rawValue: phaseValue) else {
            fatalError("Enum case not found")
        }
        
        
        return Contest(id: id, name: name, type: type, phase: phase, frozen: frozen, durationSeconds: durationSeconds, startTimeSeconds: startTimeSeconds.value, relativeTimeSeconds: relativeTimeSeconds.value, preparedBy: preparedBy, websiteUrl: websiteUrl, descr1ption: descr1ption, difficulty: difficulty.value, kind: kind, icpcRegion: icpcRegion, country: country, city: city, season: season)
    }

    convenience init(model: Contest) {
        self.init()
        
        self.id = model.id        
        self.name = model.name        
        self.type = model.type.rawValue        
        self.phase = model.phase.rawValue        
        self.frozen = model.frozen        
        self.durationSeconds = model.durationSeconds        
        self.startTimeSeconds.value = model.startTimeSeconds        
        self.relativeTimeSeconds.value = model.relativeTimeSeconds        
        self.preparedBy = model.preparedBy        
        self.websiteUrl = model.websiteUrl        
        self.descr1ption = model.descr1ption        
        self.difficulty.value = model.difficulty        
        self.kind = model.kind        
        self.icpcRegion = model.icpcRegion        
        self.country = model.country        
        self.city = model.city        
        self.season = model.season        
    }
}

extension Contest: RealmRepresentable {
    var persistenceObject: ContestRealm {
        return ContestRealm(model: self)
    }
}
