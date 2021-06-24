import XCTest
@testable import SpaceX

class MockSceneTests: XCTestCase, SceneTests {
    typealias Scene = MockScene
    var controller: Scene.Controller!
    
    override func setUp() {
        controller = MockScene.assemble(request: MockScene.Request(), viewControler: MockViewController())
    }

    func testCompositionRoot() {
        testSceneReferences()
    }
    
    func testPresenterReferencesControllerWeakly() {
        testRouterReferencesControllerWeakly(newController: MockViewController())
    }

    func testRouterReferencesControllerWeakly() {
        testRouterReferencesControllerWeakly(newController: MockViewController())
    }
}
