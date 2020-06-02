import UIKit

extension Reusable {
	static var reuseIdentifier: String { return String(describing: self) }
}

extension UITableView {
	
	func register<T: UITableViewCell>(_: T.Type) where T: Reusable {
		register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
	}
	
	func dequeueReusable<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: Reusable {
		guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
			fatalError("\(T.reuseIdentifier) wasn't found!")
		}
		return cell
	}
	
}
