import Foundation

protocol LaunchesDisplayProtocol: DisplayProtocol {
    func displayLaunches(with viewModel: LaunchesScene.ViewModel)
    func updateImage(data: Data, at index: Int)
}

protocol LaunchesInteractionProtocol: InteractionProtocol {
    func fetchLaunches()
    func fetchImage(from url: String, for index: Int)
}
 
protocol LaunchesPresentationProtocol: PresentationProtocol {
    func presentLaunches(for data: Result<LaunchesScene.Data, Error>)
    func presentFetched(data: Result<Data, Error>, for index: Int)
}

protocol LaunchesRoutingProtocol: RoutingProtocol {
    func show(_ launch: LaunchesScene.ItemViewModel)
}
