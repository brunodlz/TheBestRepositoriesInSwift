import Foundation

extension URLComponents {
	
	mutating func setQueryItems(with parameters: [String: String]) {
		self.queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
	}
	
}

