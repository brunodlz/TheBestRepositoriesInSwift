import Foundation

extension URLSession {
	
	func dataTask(with request: URLRequest,
				  result: @escaping (Result<(Data?, URLResponse), Error>) -> Void)
		-> URLSessionDataTask  {
		return dataTask(with: request.url!) { (data, response, error) in
			if let error = error {
				result(.failure(error))
				return
			}
			
			guard let data = data, let response = response else {
				let error = NSError(domain: "error",
									code: 0,
									userInfo: nil)
				result(.failure(error))
				return
			}
			result(.success((data, response)))
		}
	}
	
}
