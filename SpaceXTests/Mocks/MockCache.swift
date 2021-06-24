import Foundation
@testable import SpaceX

class MockCache: ServiceProtocol & CacheWriter {
    var queriedLaunches = false
    var cachedLaunches = false

    func cache<T>(launches: T) where T : Encodable {
        cachedLaunches = true
    }
    
    func cache(data: Data, to url: String) {
    }
    
    func fetchLaunches<T>(completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
        queriedLaunches = true
        completion(.failure(MockError.test))
    }
    
    func fetchData(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
    }
}
