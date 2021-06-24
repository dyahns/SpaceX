import XCTest
@testable import SpaceX

protocol SceneTests: AnyObject {
    associatedtype Scene: AppScene
    var controller: Scene.Controller! { get set }
}

extension SceneTests where Self: XCTestCase {
    func testSceneReferences() {
        XCTAssertNotNil(controller.interactor)
        XCTAssertNotNil(controller.interactor.presenter)
        XCTAssertNotNil(controller.interactor.presenter.controller)
        XCTAssertTrue(controller.interactor.presenter.controller === controller)
        XCTAssertNotNil(controller.interactor.service)
        XCTAssertNotNil(controller.router)
        XCTAssertNotNil(controller.router.controller)
        XCTAssertTrue(controller.router.controller === controller)
    }

    func testRouterReferencesControllerWeakly(newController: Scene.Controller) {
        let router = Scene.Router.init(controller: controller)
        controller = newController
        
        addTeardownBlock {
            XCTAssertNil(router.controller)
        }
    }

    func testPresenterReferencesControllerWeakly(newController: Scene.Controller) {
        let presenter = Scene.Presenter.init(controller: controller)
        controller = newController

        addTeardownBlock {
            XCTAssertNil(presenter.controller)
        }
    }
}

