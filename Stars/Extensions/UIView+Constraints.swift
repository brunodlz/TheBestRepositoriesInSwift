import UIKit

extension UIView {
	
	func addConstraintsForAllEdges(of item: UIView) {
		let constraints: [NSLayoutConstraint] = [
			NSLayoutConstraint(item: item, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0),
			NSLayoutConstraint(item: item, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0.0),
			NSLayoutConstraint(item: item, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0),
			NSLayoutConstraint(item: item, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: 0.0),
		]
		self.addConstraints(constraints)
	}
	
}
