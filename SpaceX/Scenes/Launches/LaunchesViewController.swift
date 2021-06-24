import UIKit

class LaunchesViewController: UITableViewController {
    var interactor: Scene.Interactor!
    var router: Scene.Router!
    
    private var viewModel: LaunchesScene.ViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor.fetchLaunches()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        let message: String? = viewModel == nil ? "Requesting data..." : (viewModel!.launches.isEmpty ? "Search yelded no results." : nil)
        tableView.addBackView(text: message)

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.launches.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        guard let launch = viewModel?.launches[indexPath.row] else {
            return cell
        }
        cell.textLabel?.text = launch.name
        cell.detailTextLabel?.text = launch.date.asString
        cell.accessoryType = launch.success ? .checkmark : .none
        cell.imageView?.image = launch.image

        return cell
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let launch = viewModel?.launches[indexPath.row] else {
            return
        }
        
        router.show(launch)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard cell.imageView?.image == nil, let launch = viewModel?.launches[indexPath.row] else {
            return
        }

        if launch.image == nil, let url = launch.imageUrl {
            interactor.fetchImage(from: url, for: indexPath.row)
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }
}

extension LaunchesViewController: LaunchesDisplayProtocol {
    typealias Scene = LaunchesScene
    
    func displayLaunches(with viewModel: LaunchesScene.ViewModel) {
        self.viewModel = viewModel
        tableView.reloadData()
    }

    func updateImage(data: Data, at index: Int) {
        guard let launches = viewModel?.launches, launches.indices.contains(index), let image = UIImage(data: data) else {
            return
        }
        
        // update view model
        viewModel?.launches[index].image = image
        
        // update cell
        guard let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) else {
            return
        }
        cell.imageView?.image = image
        cell.setNeedsLayout()
    }
}
