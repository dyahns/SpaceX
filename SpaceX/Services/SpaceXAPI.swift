import Foundation

struct SpaceXAPI: ServiceProtocol {
    static let baseURL = URL(string: "https://api.spacexdata.com/v4/")!
    static let launchesQuery = "launches"
    
    private let api: API
    
    init(api: API) {
        self.api = api
    }
    
    func fetchLaunches<T: Decodable>(completion: @escaping (Result<T, Error>) -> Void) {
        let endpoint = Endpoint<T>(path: Self.launchesQuery)
        
        api.load(endpoint, completion: { (result) in
            completion(result)
        })
    }
    
    func fetchData(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        api.load(from: url, completion: { (result) in
            completion(result)
        })
    }
}

extension String {
    func injectValue(_ value: String) -> String {
        self.replacingOccurrences(of: "@@@", with: value)
    }
}
