// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import RealmSwift


final class SubmissionRealm: Object { 

    @objc dynamic var id: Int = 0  
    let contestId = RealmOptional<Int>() 
    @objc dynamic var creationTimeSeconds: Int = 0 
    @objc dynamic var relativeTimeSeconds: Int = 0 
    @objc dynamic var problem: ProblemRealm! 
    @objc dynamic var author: PartyRealm! 
    @objc dynamic var programmingLanguage: String = "" 
    @objc dynamic var verdict: String?
    @objc dynamic var testset: String! 
    @objc dynamic var passedTestCount: Int = 0 
    @objc dynamic var timeConsumedMillis: Int = 0 
    @objc dynamic var memoryConsumedBytes: Int = 0 

    
        override static func primaryKey() -> String? {
            return "id"
        }
        

}

extension SubmissionRealm: RealmObject {
    var model: Submission {
        guard let testsetValue = testset, let testset = TestSet(rawValue: testsetValue) else {
            fatalError("Enum case not found")
        }
        let verdict = self.verdict.flatMap { SubmissionVerdict(rawValue: $0) }
        
        return Submission(id: id, contestId: contestId.value, creationTimeSeconds: creationTimeSeconds, relativeTimeSeconds: relativeTimeSeconds, problem: problem.model, author: author.model, programmingLanguage: programmingLanguage, verdict: verdict, testset: testset, passedTestCount: passedTestCount, timeConsumedMillis: timeConsumedMillis, memoryConsumedBytes: memoryConsumedBytes)
    }

    convenience init(model: Submission) {
        self.init()
        
        self.id = model.id        
        self.contestId.value = model.contestId        
        self.creationTimeSeconds = model.creationTimeSeconds        
        self.relativeTimeSeconds = model.relativeTimeSeconds        
        self.problem = model.problem.persistenceObject        
        self.author = model.author.persistenceObject        
        self.programmingLanguage = model.programmingLanguage        
        self.verdict = model.verdict?.rawValue        
        self.testset = model.testset.rawValue        
        self.passedTestCount = model.passedTestCount        
        self.timeConsumedMillis = model.timeConsumedMillis        
        self.memoryConsumedBytes = model.memoryConsumedBytes        
    }
}

extension Submission: RealmRepresentable {
    var persistenceObject: SubmissionRealm {
        return SubmissionRealm(model: self)
    }
}
