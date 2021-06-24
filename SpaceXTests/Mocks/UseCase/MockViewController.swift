import Foundation
@testable import SpaceX

class MockViewController: DisplayProtocol {
    typealias Scene = MockScene
    var interactor: Scene.Interactor!
    var router: Scene.Router!
}
