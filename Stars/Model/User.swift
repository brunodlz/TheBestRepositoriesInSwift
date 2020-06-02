struct User: Codable {
	let name: String
	let avatar: String
	
	enum CodingKeys: String, CodingKey {
		case name = "login"
		case avatar = "avatar_url"
	}
}
