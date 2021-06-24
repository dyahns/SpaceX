import Foundation

enum CacheError: Error {
    case notCached(String)
    case readFailed
    case deseralizationFailed
}

extension CacheError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .notCached(let key):
            return "Value with key \(key) is not in the cache"
        case .readFailed:
            return "Failed to read data from file"
        case .deseralizationFailed:
            return "Failed to deserialize data!"
        }
    }
}
