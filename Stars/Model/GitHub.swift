struct GitHub: Codable {
	let repositoryName: String
	let stars: Int
	let user: User
	
	enum CodingKeys: String, CodingKey {
		case repositoryName = "name"
		case stars = "stargazers_count"
		case user = "owner"
	}
}
