import Foundation

extension Date {
    private static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        return formatter
      }()

    var asString: String {
        Date.formatter.string(from: self)
    }
}
