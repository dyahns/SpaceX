import Foundation

struct LaunchesRouter: LaunchesRoutingProtocol {
    typealias Scene = LaunchesScene
    weak var controller: Scene.Controller?
    
    init(controller: Scene.Controller) {
        self.controller = controller
    }
    
    func show(_ launch: LaunchesScene.ItemViewModel) {
        print("Selected \(launch.name)")
    }
}
