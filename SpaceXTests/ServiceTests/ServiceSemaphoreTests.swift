import XCTest
@testable import SpaceX

class ServiceSemaphoreTests: XCTestCase {
    var semaphore: ServiceSemaphore!
    var failoverFired = false

    override func setUp() {
        semaphore = ServiceSemaphore()
        failoverFired = false
    }

    func testFailoverFiresIfPriorityDoesNot() {
        semaphore.failoverHandler {
            self.failoverFired = true
        }
        XCTAssertTrue(failoverFired)
    }
    
    func testFailoverFiresIfPriorityFails() {
        semaphore.priorityHandler(success: false) {}
        
        semaphore.failoverHandler {
            self.failoverFired = true
        }
        XCTAssertTrue(failoverFired)
    }

    func testFailoverIsSkippedIfPrioritySucceeds() {
        semaphore.priorityHandler(success: true) {}
        
        semaphore.failoverHandler {
            self.failoverFired = true
        }
        XCTAssertFalse(failoverFired)
    }

}
