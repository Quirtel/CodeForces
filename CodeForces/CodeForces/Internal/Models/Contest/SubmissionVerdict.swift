import Foundation

enum SubmissionVerdict: String, Codable {
    case FAILED
    case OK
    case PARTIAL
    case COMPILATION_ERROR
    case RUNTIME_ERROR
    case WRONG_ANSWER
    case PRESENTATION_ERROR
    case TIME_LIMIT_EXCEEDED
    case MEMORY_LIMIT_EXCEEDED
    case IDLENESS_LIMIT_EXCEEDED
    case SECURITY_VIOLATED
    case CRASHED
    case INPUT_PREPARATION_CRASHED
    case CHALLENGED
    case SKIPPED
    case TESTING
    case REJECTED
}
