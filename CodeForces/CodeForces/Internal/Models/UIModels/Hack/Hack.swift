import Foundation

//sourcery: RealmPersistable
struct Hack: Codable {
    let id: Int
    let creationTimeSeconds: Int
    let hacker: Party
    let defender: Party
    let verdict: HackVerdict?
    let problem: Problem
    let test: String?
    let judgeProtocol: JudgeProtocol?
}
