import Foundation

class ServiceSemaphore {
    private var isPrioritySuccessful = false
    private let semaphore = DispatchSemaphore(value: 1)

    func priorityHandler(success: Bool, completion: @escaping () -> Void) {
        semaphore.wait()
        isPrioritySuccessful = success
        
        completion()
        semaphore.signal()
    }

    func failoverHandler(completion: @escaping () -> Void) {
        semaphore.wait()
        guard !isPrioritySuccessful else {
            // ignore failover data source if got it via priority source
            semaphore.signal()
            return
        }
        
        completion()
        semaphore.signal()
    }
}
