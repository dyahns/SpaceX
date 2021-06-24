import Foundation

struct SpaceXService: RootServiceProtocol {
    static let defaultConfig = SpaceXService(api: SpaceXAPI(api: API(urlSession: URLSession.shared, baseURL: SpaceXAPI.baseURL)), cache: SpaceXCache())
    
    init(api: ServiceProtocol, cache: (ServiceProtocol & CacheWriter)?) {
        self.api = api
        self.cache = cache
    }
    
    private let api: ServiceProtocol
    private let cache: (ServiceProtocol & CacheWriter)?

    func fetchLaunches<T: Codable>(completion: @escaping (Result<T, Error>) -> Void) {
        let semaphore = ServiceSemaphore()

        api.fetchLaunches { (result: Result<T, Error>) in
            let data = try? result.get()
            semaphore.priorityHandler(success: data != nil) {
                completion(result)
            }
            
            if let data = data {
                self.cache?.cache(launches: data)
            }
        }

        cache?.fetchLaunches { (result) in
            semaphore.failoverHandler {
                completion(result)
            }
        }
    }
    
    func fetchData(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        cache?.fetchData(url: url, completion: { (result) in
            guard let _ = try? result.get() else {
                self.api.fetchData(url: url) { (result) in
                    if let data = try? result.get() {
                        self.cache?.cache(data: data, to: url)
                    }

                    completion(result)
                }
                return
            }
            
            completion(result)
        })
    }
}
