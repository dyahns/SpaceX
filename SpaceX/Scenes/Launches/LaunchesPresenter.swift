import Foundation

struct LaunchesPresenter: LaunchesPresentationProtocol {
    typealias Scene = LaunchesScene
    weak var controller: Scene.Controller?
    
    init(controller: Scene.Controller) {
        self.controller = controller
    }
    
    func presentLaunches(for data: Result<LaunchesScene.Data, Error>) {
        relayResult(data) { (data) in
            let viewModel = LaunchesScene.ViewModel(response: data)
            self.controller?.displayLaunches(with: viewModel)
        }
    }
    
    func presentFetched(data: Result<Data, Error>, for index: Int) {
        relayResult(data) {
            self.controller?.updateImage(data: $0, at: index)
        }
    }
}
