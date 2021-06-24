import Foundation

struct SpaceXCache {
    static let launchesKey = "Launches"
}

extension SpaceXCache: ServiceProtocol {
    func fetchLaunches<T: Codable>(completion: @escaping (Result<T, Error>) -> Void) {
        FileManager.default.readFromCache(with: Self.launchesKey) { (result) in
            completion(result)
        }
    }
    
    func fetchData(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        FileManager.default.readFromCache(with: url.base64) { (result) in
            completion(result)
        }
    }
}

extension SpaceXCache: CacheWriter {
    func cache<T: Encodable>(launches: T) {
        FileManager.default.cache(data: launches, with: Self.launchesKey)
    }
    
    func cache(data: Data, to url: String) {
        FileManager.default.cache(data: data, with: url.base64)
    }
}
