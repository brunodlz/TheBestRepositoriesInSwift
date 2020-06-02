enum GitHubRouter: APIServiceRouter {
	case page(String, String, String)
}

extension GitHubRouter {
	
	var path: String {
		return "repositories"
	}
	
	var method: HTTPMethod {
		return .get
	}
	
	var parameters: QueryItems? {
		switch self {
			case .page(let query, let sort, let page):
				return ["q": query,
						"sort": sort,
						"page": page]
		}
	}
	
}
