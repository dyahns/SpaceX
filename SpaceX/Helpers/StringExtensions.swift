import Foundation

extension String {
    var base64: String {
        let data = self.data(using: String.Encoding.utf8)
        return data!.base64EncodedString(options: [])
    }
}
