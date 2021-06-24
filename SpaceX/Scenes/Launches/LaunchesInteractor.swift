import Foundation

struct LaunchesInteractor: LaunchesInteractionProtocol {
    typealias Scene = LaunchesScene
    let presenter: Scene.Presenter
    let service: RootServiceProtocol

    init(request: Scene.Request, service: RootServiceProtocol, presenter: Scene.Presenter) {
        self.presenter = presenter
        self.service = service
    }
    
    func fetchLaunches() {
        DispatchQueue.global().async {
            self.service.fetchLaunches { (result) in
                self.presenter.presentLaunches(for: result)
            }
        }
    }
    
    func fetchImage(from url: String, for index: Int) {
        DispatchQueue.global().async {
            self.service.fetchData(url: url) { (result) in
                self.presenter.presentFetched(data: result, for: index)
            }
        }
    }
}
