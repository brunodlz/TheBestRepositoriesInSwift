import Foundation

extension URLRequestConvertible {
    public var urlRequest: URLRequest? { return try? asURLRequest() }
}

extension URLRequest: URLRequestConvertible {
    public func asURLRequest() throws -> URLRequest { return self }
}

extension URLRequest {
	
    public init(url: URL, method: HTTPMethod, headers: HTTPHeaders? = nil) throws {
        self.init(url: url)

		httpMethod = method.rawValue

        if let headers = headers {
            for (headerField, headerValue) in headers {
                setValue(headerValue, forHTTPHeaderField: headerField)
            }
        }
    }
	
}
