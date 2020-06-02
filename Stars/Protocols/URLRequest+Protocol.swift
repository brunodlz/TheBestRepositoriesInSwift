import Foundation

public protocol URLRequestConvertible {
    func asURLRequest() throws -> URLRequest
}
