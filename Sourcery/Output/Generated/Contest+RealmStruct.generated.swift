// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import RealmSwift
final class ContestObject: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var type: ContestType = completeRealmExpression
    @objc dynamic var phase: PhaseType = completeRealmExpression
    @objc dynamic var frozen: Bool = false
    @objc dynamic var durationSeconds: Int = 0
    @objc dynamic var startTimeSeconds: Int? = nil
    @objc dynamic var relativeTimeSeconds: Int? = nil
    @objc dynamic var preparedBy: String? = nil
    @objc dynamic var websiteUrl: String? = nil
    @objc dynamic var description: String? = nil
    @objc dynamic var difficulty: Int? = nil
    @objc dynamic var kind: String? = nil
    @objc dynamic var icpcRegion: String? = nil
    @objc dynamic var country: String? = nil
    @objc dynamic var city: String? = nil
    @objc dynamic var season: String? = nil
    override static func primaryKey() -> String? {
        return "id"
    }
}
extension Contest: RealmRepresentable {
    var realmObject: ContestObject {
        let contest = ContestObject()
        contest.id = id
        contest.name = name
        contest.type = type
        contest.phase = phase
        contest.frozen = frozen
        contest.durationSeconds = durationSeconds
        contest.startTimeSeconds = startTimeSeconds
        contest.relativeTimeSeconds = relativeTimeSeconds
        contest.preparedBy = preparedBy
        contest.websiteUrl = websiteUrl
        contest.description = description
        contest.difficulty = difficulty
        contest.kind = kind
        contest.icpcRegion = icpcRegion
        contest.country = country
        contest.city = city
        contest.season = season
        return contest
    }
}
extension ContestObject: StructRepresentable {
    var `struct`: Contest {
        return Contest(id: id, name: name, type: type, phase: phase, frozen: frozen, durationSeconds: durationSeconds, startTimeSeconds: startTimeSeconds, relativeTimeSeconds: relativeTimeSeconds, preparedBy: preparedBy, websiteUrl: websiteUrl, description: description, difficulty: difficulty, kind: kind, icpcRegion: icpcRegion, country: country, city: city, season: season)
    }
}
