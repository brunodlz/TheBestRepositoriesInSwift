import Foundation

@testable import Stars

final class ApiServiceSpy: APIServiceType {
	
	enum State {
		case success(Data)
		case fail
	}
	
	var requestCalled: Bool = false
	
	private let state: State
	let error: APIServiceError
	
	init(state: State, error: APIServiceError = .unknownError("timeout")) {
		self.state = state
		self.error = error
	}
	
	func request<T: Decodable>(router: APIServiceRouter, completion: @escaping (Result<T, APIServiceError>) -> Void) {
		requestCalled = true
	
		switch state {
			case .success(let data):
				let values = try! JSONDecoder().decode(T.self, from: data)
				completion(.success(values))
			case .fail:
				completion(.failure(error))
		}
	}
	
}
