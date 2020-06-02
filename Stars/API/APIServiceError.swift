import Foundation

enum APIServiceError: Error, Equatable {
	case apiError
	case decodeError
	case unknownError(String)
	
	var description: String {
        switch self {
		case .apiError:
			return "An unexpected API error has occurred."
		case .decodeError:
			return "An error occurred while trying to decode."
        case .unknownError:
            return "Unknown server error. Try again."
        }
    }
}
