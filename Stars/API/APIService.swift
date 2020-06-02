import Foundation

protocol APIServiceType: class {
	func request<T: Decodable>(router: APIServiceRouter,
							   completion: @escaping (Result<T, APIServiceError>) -> Void)
}

final class APIService: APIServiceType {
	
	func request<T: Decodable>(router: APIServiceRouter,
							   completion: @escaping (Result<T, APIServiceError>) -> Void) {
		DispatchQueue.global(qos: .background).async {
			do {
				let request = try router.asURLRequest()
				
				URLSession.shared.dataTask(with: request) { result in
					switch result {
						case .success(let (data, response)):
							guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
								completion(.failure(.apiError))
								return
							}
							
							guard let data = data else {
								completion(.failure(.unknownError("Data is nil!")))
								return
							}
							
							do {
								let values = try JSONDecoder().decode(T.self, from: data)
								completion(.success(values))
							} catch {
								completion(.failure(.decodeError))
						}
						case .failure(let error):
							completion(.failure(.unknownError(error.localizedDescription)))
					}
				}.resume()
			} catch {
				completion(.failure(.unknownError(error.localizedDescription)))
			}
		}
		
	}
	
}
