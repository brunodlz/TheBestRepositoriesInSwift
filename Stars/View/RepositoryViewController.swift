import UIKit

final class RepositoryViewController: UIViewController {
    
	private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
		tableView.register(RepositoryCell.self)
		tableView.showsVerticalScrollIndicator = false
		tableView.showsHorizontalScrollIndicator = false
        return tableView
    }()
	
	private lazy var refreshControl: UIRefreshControl = {
		let refresh = UIRefreshControl()
		refresh.tintColor = .white
		refresh.translatesAutoresizingMaskIntoConstraints = false
		refresh.addTarget(self, action: #selector(refreshContent), for: .valueChanged)
		refresh.attributedTitle = NSAttributedString(string: "Fetching more repositories",
													 attributes: [NSAttributedString.Key.foregroundColor: ColorPalette.white])
		return refresh
	}()
	
	private let viewModel: GitHubViewModelType

	private var isLoading: Bool = false
	  
	init(viewModel: GitHubViewModelType) {
		self.viewModel = viewModel
		
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Repositories"
        
		tableView.refreshControl = refreshControl
		tableView.dataSource = viewModel.datasource
		tableView.prefetchDataSource = self
		
		view.backgroundColor = ColorPalette.white
        view.addSubview(tableView)
		view.addConstraintsForAllEdges(of: tableView)
		
		loadContent()
	}

	private func loadContent(refresh status: Bool = false) {
		guard !isLoading else { return }
		
		isLoading = true
		
		viewModel.loadRepositories(refresh: status) { [weak self] models in
			DispatchQueue.main.async {
				guard let self = self else { return }
				switch models {
					case .success(let repositories):
						self.isLoading = false
						self.refreshControl.endRefreshing()
						
						self.viewModel.updateNumberOfRows(with: repositories)
						self.tableView.reloadData()
					case .failure(let error):
						self.alert(with: (error as APIServiceError).description)
				}
			}
		}
	}
	
	private func alert(with message: String) {
		let controller = UIAlertController(title: "Attention", message: message, preferredStyle: .alert)
		controller.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
		present(controller, animated: true, completion: nil)
	}
	
	@objc private func refreshContent(_ sender: Any) {
		loadContent(refresh: true)
	}
}

extension RepositoryViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

extension RepositoryViewController: UITableViewDataSourcePrefetching {
	
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
		if indexPaths.contains(where: lastRow) {
			loadContent()
		}
    }

	private func lastRow(for indexPath: IndexPath) -> Bool {
		return indexPath.row >= viewModel.numberOfRows()
	}
	
}
