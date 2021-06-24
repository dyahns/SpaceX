import Foundation

// Controller
protocol DisplayProtocol: AnyObject {
    associatedtype Scene: AppScene
    var interactor: Scene.Interactor! { get set }
    var router: Scene.Router! { get set }
    func displayError(_ error: Error)
}

// Interactor
protocol InteractionProtocol {
    associatedtype Scene: AppScene
    var presenter: Scene.Presenter { get }
    var service: RootServiceProtocol { get }
    init(request: Scene.Request, service: RootServiceProtocol, presenter: Scene.Presenter)
}

// Presenter
protocol PresentationProtocol {
    associatedtype Scene: AppScene
    var controller: Scene.Controller? { get }
    init(controller: Scene.Controller)
}

extension PresentationProtocol {
    func onMain(_ action: @escaping () -> ()) {
        DispatchQueue.main.async {
            action()
        }
    }
    
    func relayResult<T>(_ result: Result<T, Error>, onSuccess: @escaping (T) -> Void) {
        switch result {
        case .success(let success):
            onMain {
                onSuccess(success)
            }

        case .failure(let error):
            onMain {
                self.controller?.displayError(error)
            }
        }
    }
}

// Router
protocol RoutingProtocol {
    associatedtype Scene: AppScene
    var controller: Scene.Controller? { get }
    init(controller: Scene.Controller)
}
