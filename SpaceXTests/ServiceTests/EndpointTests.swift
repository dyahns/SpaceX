import XCTest
@testable import SpaceX

class ResourceTests: XCTestCase {
    func test_initWithPath_handlesParsingDecodableModels() {
        let endpoint = Endpoint<MockModel>(path: "", query: "")
        let result = endpoint.parse(MockModel.data)
        guard let model = try? result.get() else {
            XCTFail("Bad JSON")
            return
        }
        
        XCTAssertEqual(model, MockModel.model)
    }
}

