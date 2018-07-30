import Foundation

enum SubmissionVerdict: String, Codable {
    case failed = "FAILED"
    case ok = "OK"
    case partial = "PARTIAL"
    case compilationError = "COMPILATION_ERROR"
    case runtimeError = "RUNTIME_ERROR"
    case wrongAnswer = "WRONG_ANSWER"
    case presentationError = "PRESENTATION_ERROR"
    case timeLimitExceeded = "TIME_LIMIT_EXCEEDED"
    case memoryLimitExceeded = "MEMORY_LIMIT_EXCEEDED"
    case idlenessLimitExceeded = "IDLENESS_LIMIT_EXCEEDED"
    case security_Violated = "SECURITY_VIOLATED"
    case crashed = "CRASHED"
    case inputPreparationCrashed = "INPUT_PREPARATION_CRASHED"
    case challenged = "CHALLENGED"
    case skipped = "SKIPPED"
    case testing = "TESTING"
    case rejected = "REJECTED"
}
