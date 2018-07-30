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
    let startTimeSeconds = RealmOptional<Int>()
    let relativeTimeSeconds = RealmOptional<Int>()
    @objc dynamic var preparedBy: String? = nil
    @objc dynamic var websiteUrl: String? = nil
    @objc dynamic var descr1ption: String? = nil
    let difficulty = RealmOptional<Int>()
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
        contest.startTimeSeconds.value = startTimeSeconds
        contest.relativeTimeSeconds.value = relativeTimeSeconds
        contest.preparedBy = preparedBy
        contest.websiteUrl = websiteUrl
        contest.descr1ption = description
        contest.difficulty.value = difficulty
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
        return Contest(id: id, name: name, type: type, phase: phase, frozen: frozen, durationSeconds: durationSeconds, startTimeSeconds: startTimeSeconds.value, relativeTimeSeconds: relativeTimeSeconds.value, preparedBy: preparedBy, websiteUrl: websiteUrl, description: descr1ption, difficulty: difficulty.value, kind: kind, icpcRegion: icpcRegion, country: country, city: city, season: season)
    }
}
