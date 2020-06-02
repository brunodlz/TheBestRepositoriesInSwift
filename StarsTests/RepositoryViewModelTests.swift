import XCTest
@testable import Stars

class RepositoryViewModelTests: XCTestCase {
	
	func testFetchGithubSingleResult() throws {
		let json = dummyAPI()
		let data = json.data(using: .utf8)!
		
		let datasource = RepositoryDataSource()
		let apiServiceSpy = ApiServiceSpy(state: .success(data))
		let sut = RepositoryViewModel(service: apiServiceSpy, datasource: datasource)

		var result: Result<[GitHub], APIServiceError>?
		
		sut.loadRepositories(completion: { result = $0 })
		
		XCTAssertEqual(apiServiceSpy.requestCalled, true)
		
		let values = try result?.get()
		
		XCTAssertEqual(values?.count, 1, "Should contain at least one object in the list")
		
		let model = values?.first!
		XCTAssertEqual(model?.repositoryName, "awesome-ios")
		XCTAssertEqual(model?.stars, 34969)
		XCTAssertEqual(model?.user.name, "vsouza")
		XCTAssertEqual(model?.user.avatar, "https://avatars2.githubusercontent.com/u/484656?v=4")
	}
	
	func testFetchStarsFail() {
		let timeout = "Timeout"
		
		let datasource = RepositoryDataSource()
		let apiServiceSpy = ApiServiceSpy(state: .fail, error: .unknownError(timeout))
		let sut = RepositoryViewModel(service: apiServiceSpy, datasource: datasource)
		
		sut.loadRepositories() { (result: Result<[GitHub], APIServiceError>) in
			if case .failure(let error) = result {
				switch error {
					case .unknownError(let message):
						XCTAssertEqual(message, timeout)
					default: break
				}
			}
		}

		XCTAssertEqual(apiServiceSpy.requestCalled, true)
	}
	
	private func dummyAPI() -> String {
		return """
		{
			"items": [
				{
					"name": "awesome-ios",
					"full_name": "vsouza/awesome-ios",
					"owner": {
						"login": "vsouza",
						"avatar_url": "https://avatars2.githubusercontent.com/u/484656?v=4",
					},
					"stargazers_count": 34969
				}
			]
		}
		"""
	}
}
