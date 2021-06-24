import XCTest
@testable import SpaceX

class SpaceXAPITests: XCTestCase {
    let url = URL(string: "https://api.spacexdata.com/v4/")!
    let urlSession = MockURLSession()

    func testFetchLaunchesSendsAPIRequest() {
        let service = SpaceXAPI(api: API(urlSession: urlSession, baseURL: url))

        service.fetchLaunches { (result: Result<[Launch], Error>) in
        }
        
        XCTAssertEqual(urlSession.lastRequest?.httpMethod, "GET")
        XCTAssertEqual(urlSession.lastRequest?.url?.absoluteString, "\(SpaceXAPI.baseURL)\(SpaceXAPI.launchesQuery)")
    }
}
