import Foundation

enum NetworkErrors: Error {
    case responseStatusFailed(comment: String)
    case connectionError
    case badResponseCode(code: Int)
}

enum CommonErrors: Error {
    case error(description: String)
    case fatalError(description: String)
    case serializationError
}

enum RealmErrors: Error {
    case realmNotFoundError
    case realmCannotSaveError
}

extension NetworkErrors: LocalizedError {
    var errorDescription: String? {
        return L10n.Error.Network.message
    }
}

extension CommonErrors: LocalizedError {
    var errorDescription: String? {
        return L10n.Error.Common.message
    }
}

extension RealmErrors: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .realmNotFoundError:
            return L10n.Error.Realm.Notfound.message
        case .realmCannotSaveError:
            return L10n.Error.Realm.Cannotsave.message
        }
    }
}
