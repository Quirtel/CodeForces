import Foundation

enum Result<T: Codable> {
    case success(Response<T>)
    case error(Error)
}

enum ResponceStatuses: String, Codable {
    case OK
    case FAILED
}

struct Response<T: Codable>: Codable {
    let status: ResponceStatuses
    let comment: String?
    let result: T?
}
