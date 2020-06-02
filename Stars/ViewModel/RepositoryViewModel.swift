import Foundation

typealias callback = (Result<[GitHub], APIServiceError>) -> Void

protocol GitHubViewModelType: class {
	func loadRepositories(refresh: Bool, completion: @escaping callback)
	func updateNumberOfRows(with repositories: [GitHub])
	func numberOfRows() -> Int
	
	var datasource: RepositoryDataSource { get }
}

final class RepositoryViewModel: GitHubViewModelType {
	
	private let service: APIServiceType
	private var currentPage: Int = 0
	
	let datasource: RepositoryDataSource
	
	init(service: APIServiceType, datasource: RepositoryDataSource) {
		self.service = service
		self.datasource = datasource
	}
	
	func loadRepositories(refresh: Bool = false, completion: @escaping callback) {
		currentPage += 1
		
		if refresh {
			currentPage = 1
		}
		
		let gitHubRouter = createRouter(currentPage: currentPage)
		
		self.service.request(router: gitHubRouter) { (result: Result<Page, APIServiceError>) in
			switch result {
				case .success(let pages):
					let repositories = pages.items.map { $0 }
					completion(.success(repositories))
				case .failure(let error):
					completion(.failure(error))
			}
		}
	}

	func updateNumberOfRows(with repositories: [GitHub]) {
		datasource.data.value.append(contentsOf: repositories)
	}
	
	func numberOfRows() -> Int {
		return datasource.data.value.count - 1
	}
	
	private func createRouter(currentPage: Int) -> APIServiceRouter {
		return GitHubRouter.page("language:swift", "stars", "\(currentPage)")
	}
	
}
