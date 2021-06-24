import Foundation
@testable import SpaceX

struct MockService: RootServiceProtocol {
    func fetchLaunches<T>(completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
    }
    
    func fetchData(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
    }
}
