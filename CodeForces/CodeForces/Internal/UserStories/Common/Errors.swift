import Foundation

enum NetworkErrors: Error {
    case responseStatusFailed(comment: String)
    case connectionError(moyaError: Error)
    case badResponseCode(code: Int)
}

enum CommonErrors: Error {
    case error(description: String)
    case fatalError(description: String)
    case serializationError
    case realmNotFoundError
}
