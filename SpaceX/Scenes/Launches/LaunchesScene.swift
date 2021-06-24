import UIKit

enum LaunchesScene: AppScene {
    typealias Controller = LaunchesViewController
    typealias Interactor = LaunchesInteractor
    typealias Presenter = LaunchesPresenter
    typealias Router = LaunchesRouter

    static let viewResource: (storyboard: String, identifier: String?) = ("Launches", nil)
    static let service: RootServiceProtocol = SpaceXService.defaultConfig

    struct Request {
    }

    typealias Data = [Launch]

    struct ViewModel {
        var launches: [ItemViewModel]
        
        init(response: Data) {
            launches = response.map { LaunchesScene.ItemViewModel($0) }
        }
    }
    
    struct ItemViewModel {
        let name: String
        let date: Date
        let success: Bool
        let imageUrl: String?
        var image: UIImage?
        
        init(_ launch: Launch) {
            name = launch.name
            date = launch.dateUnix
            success = launch.success ?? false
            imageUrl = launch.image
        }
    }
}
