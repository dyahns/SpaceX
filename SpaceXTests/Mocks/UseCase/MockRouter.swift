import Foundation
@testable import SpaceX

struct MockRouter: RoutingProtocol {
    typealias Scene = MockScene
    weak var controller: Scene.Controller?
    
    init(controller: Scene.Controller) {
        self.controller = controller
    }
}
