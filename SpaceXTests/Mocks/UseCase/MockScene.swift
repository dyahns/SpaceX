import Foundation
@testable import SpaceX

enum MockScene: AppScene {
    typealias Controller = MockViewController
    typealias Interactor = MockInteractor
    typealias Presenter = MockPresenter
    typealias Router = MockRouter

    static let viewResource: (storyboard: String, identifier: String?) = ("", nil)
    static let service: RootServiceProtocol = MockService()

    struct Request {}

    struct Data: Codable {}
}
