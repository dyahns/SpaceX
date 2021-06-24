import Foundation

struct Endpoint<Response> {
    let path: String
    let query: String?
    let method: String
    let parse: (Data) -> Result<Response, Error>
}

extension Endpoint where Response: Decodable {
    init(path: String) {
        self.init(path: path, query: nil)
    }
    
    init(path: String, query: String?) {
        self.path = path
        self.query = query
        self.method = "GET"
        
        parse = { response in
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .secondsSince1970
                
                return .success(try decoder.decode(Response.self, from: response))
            } catch {
                return .failure(error)
            }
        }
    }
}

extension Endpoint: CustomStringConvertible {
    var description: String {
        "\(method) \(path)\(query ?? "")"
    }
}
