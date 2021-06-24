import Foundation

protocol ServiceProtocol {
    func fetchLaunches<T: Codable>(completion: @escaping (Result<T, Error>) -> Void)
    func fetchData(url: String, completion: @escaping (Result<Data, Error>) -> Void)
}

protocol RootServiceProtocol: ServiceProtocol {
}

protocol CacheWriter {
    func cache<T: Encodable>(launches: T)
    func cache(data: Data, to url: String)
}
