import XCTest
@testable import SpaceX

class LaunchesTests: XCTestCase, SceneTests {
    typealias Scene = LaunchesScene
    var controller: Scene.Controller!
    
    override func setUp() {
        controller = LaunchesScene.assemble(request: LaunchesScene.Request(), viewControler: LaunchesViewController(), service: MockService())
    }
    
    func testCompositionRoot() {
        testSceneReferences()
    }
    
    func testPresenterReferencesControllerWeakly() {
        testPresenterReferencesControllerWeakly(newController: LaunchesViewController())
    }
    
    func testRouterReferencesControllerWeakly() {
        testRouterReferencesControllerWeakly(newController: LaunchesViewController())
    }
}
