import UIKit

struct StatusCellModel {
    var participantName = String()
    var taskName = String()
    var taskIndex = String()
    var verdict: SubmissionVerdict? = nil
    var sentTime = String()
    var language = String()
    var timeConsumption = String()
    var memoryConsumption = String()
    var passedTestCount = String()
    var participantIsTeam = false
    
    init(contestId: Int, submission: Submission, formatterRef: DateFormatter) {
        
        let taskName = String(contestId) + submission.problem.index +
            " - " + submission.problem.name
        
        if let teamName = submission.author.teamName {
            self.participantName = teamName
            participantIsTeam = true
        } else if let handle = submission.author.members.first {
            self.participantName = handle.handle
            participantIsTeam = false
        }
        
        self.taskName = submission.problem.name
        self.taskIndex = submission.problem.index
        
        if let verdict = submission.verdict {
            self.verdict = verdict
        }
        
        let startTime = Date(timeIntervalSince1970:
            TimeInterval(submission.creationTimeSeconds))
        
        self.sentTime = formatterRef.string(from: startTime)
        self.language = submission.programmingLanguage
        self.timeConsumption = String(submission.timeConsumedMillis)
        self.memoryConsumption = String(submission.memoryConsumedBytes)
        self.passedTestCount = String(submission.passedTestCount + 1)
    }
}
