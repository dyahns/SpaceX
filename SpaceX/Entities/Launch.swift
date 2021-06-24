import Foundation

struct Launch: Codable {
    let name: String
    let dateUnix: Date
    let success: Bool?
    let links: Links?
    
    var image: String? {
        links?.patch?.small
    }
    
    struct Links: Codable {
        let patch: Patch?

        struct Patch: Codable {
            let small: String?
        }
    }
}
