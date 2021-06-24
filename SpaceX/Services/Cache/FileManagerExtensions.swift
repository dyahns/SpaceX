import Foundation

extension FileManager {
    func cache<T: Encodable>(data: T, with key: String) {
        guard let data = try? JSONEncoder().encode(data) else {
            assertionFailure("Error: Failed to serialize data!")
            return
        }

        cache(data: data, with: key)
    }
    
    func cache(data: Data, with key: String) {
        guard let file = cacheURL(with: key) else {
            return
        }
        
        do {
            try data.write(to: file)
            print("Saved \(key)")
        } catch {
            assertionFailure("Save failed!")
        }
    }
    
    func readFromCache<T: Decodable>(with key: String, completion: (Result<T, Error>) -> Void) {
        readFromCache(with: key) { (result) in
            let result = result.flatMap { (data) -> Result<T, Error> in
                guard let decoded = try? JSONDecoder().decode(T.self, from: data) else {
                    return .failure(CacheError.deseralizationFailed)
                }
                
                return .success(decoded)
            }

            completion(result)
        }
    }

    func readFromCache(with key: String, completion: (Result<Data, Error>) -> Void) {
        guard let url = cacheURL(with: key), self.fileExists(atPath: url.path) else {
            completion(.failure(CacheError.notCached(key)))
            return
        }
        
        guard let data = try? Data(contentsOf: url) else {
            completion(.failure(CacheError.readFailed))
            return
        }
        
        completion(.success(data))
    }

    private func cacheURL(with key: String) -> URL? {
        guard let documentDirURL = try? self.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true) else {
            print("Error: Failed to get the directory!")
            return nil
        }
        
        return documentDirURL.appendingPathComponent(key).appendingPathExtension("dat")
    }
}

