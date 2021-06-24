import Foundation
import UIKit

protocol AppScene {
    associatedtype Controller: DisplayProtocol where Controller.Scene == Self
    associatedtype Interactor: InteractionProtocol where Interactor.Scene == Self
    associatedtype Presenter: PresentationProtocol where Presenter.Scene == Self
    associatedtype Router: RoutingProtocol where Router.Scene == Self
    associatedtype Request
    associatedtype Data

    static var viewResource: (storyboard: String, identifier: String?) { get }
    static var service: RootServiceProtocol { get }
}

extension AppScene {
    static func assemble(request: Request, viewControler: Controller? = nil, service: RootServiceProtocol? = nil) -> Controller {
        let controller = viewControler ?? instantiateFromResource()
        let presenter = Presenter.init(controller: controller)
        controller.interactor = Interactor.init(request: request, service: service ?? self.service, presenter: presenter)
        controller.router = Router.init(controller: controller)

        return controller
    }
    
    static private func instantiateFromResource() -> Controller {
        let storyboard = UIStoryboard.init(name: Self.viewResource.storyboard, bundle: nil)
        if let identifier = Self.viewResource.identifier {
            return storyboard.instantiateViewController(identifier: identifier) as! Controller
        } else {
            return storyboard.instantiateInitialViewController() as! Controller
        }
    }
}
