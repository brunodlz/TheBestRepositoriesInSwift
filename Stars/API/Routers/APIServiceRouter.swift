import Foundation

public typealias HTTPHeaders = [String: String]
public typealias QueryItems = [String: String]

protocol APIServiceRouter: URLRequestConvertible {
	var baseURL: URL { get }
	var path: String { get }
	var method: HTTPMethod { get }
	var parameters: QueryItems? { get }
	var headers: HTTPHeaders? { get }
	var contentType: String { get }
}

extension APIServiceRouter {
	
	var baseURL: URL {
        return URL(string: "https://api.github.com/search/")!
	}

	var headers: HTTPHeaders? {
		return nil
	}
	
	var contentType: String {
		return "application/json"
	}
	
	func asURLRequest() throws -> URLRequest {
		let url = baseURL.appendingPathComponent(path)
		var urlRequest = try URLRequest(url: url, method: method, headers: headers)
		urlRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")
		
		guard let parameters = parameters else { return urlRequest }
		
		var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
		components?.setQueryItems(with: parameters)
		
		urlRequest.url = components?.url
		
		return urlRequest
	}
}
