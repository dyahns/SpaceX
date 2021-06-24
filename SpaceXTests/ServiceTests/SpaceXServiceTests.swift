import XCTest
@testable import SpaceX

class SpaceXServiceTests: XCTestCase {
    var service: SpaceXService!
    var api: MockAPIService!
    var cache: MockCache!
    
    override func setUp() {
        api = MockAPIService()
        cache = MockCache()
        service = SpaceXService(api: api, cache: cache)
    }
    
    func testFetchLaunchesHitsBothCacheAndApi() {
        let _ = service.fetchLaunches { (result: Result<MockModel, Error>) in
        }
        
        XCTAssertTrue(api.queriedLaunches)
        XCTAssertTrue(cache.queriedLaunches)
    }

    func testFetchLaunchesFromApiWritesToCache() {
        let _ = service.fetchLaunches { (result: Result<MockModel, Error>) in
        }
        
        XCTAssertTrue(api.queriedLaunches)
        XCTAssertTrue(cache.cachedLaunches)
    }
    
    func testFetchLaunchesOnApiFailureNoWritingToCache() {
        api.apiShouldSucceed = false
        let _ = service.fetchLaunches { (result: Result<MockModel, Error>) in
        }
        
        XCTAssertTrue(api.queriedLaunches)
        XCTAssertFalse(cache.cachedLaunches)
    }
}
