import Foundation
@testable import SpaceX

class MockAPIService: ServiceProtocol {
    var apiShouldSucceed = true
    var queriedLaunches = false

    func fetchLaunches<T>(completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
        queriedLaunches = true
        
        if apiShouldSucceed {
            completion(Result.success(MockModel(value: 1) as! T))
        } else {
            completion(.failure(MockError.test))
        }
    }
    
    func fetchData(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
    }
}
