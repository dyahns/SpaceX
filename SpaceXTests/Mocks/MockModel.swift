import Foundation

struct MockModel: Codable, Equatable {
    let value: Int
    static var data = Data("{\"value\": 1}".utf8)
    static var model = MockModel(value: 1)
}
