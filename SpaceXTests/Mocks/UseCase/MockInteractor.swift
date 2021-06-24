import Foundation
@testable import SpaceX

struct MockInteractor: InteractionProtocol {
    typealias Scene = MockScene
    var presenter: Scene.Presenter
    var service: RootServiceProtocol
    
    init(request: Scene.Request, service: RootServiceProtocol, presenter: Scene.Presenter) {
        self.presenter = presenter
        self.service = service
    }
}
