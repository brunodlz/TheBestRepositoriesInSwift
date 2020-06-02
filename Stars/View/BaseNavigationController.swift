import UIKit

final class BaseNavigationController: UINavigationController {

	override func viewDidLoad() {
		super.viewDidLoad()

		self.navigationBar.tintColor = ColorPalette.indigo
		self.navigationBar.barTintColor = ColorPalette.indigo
		self.navigationBar.backgroundColor = ColorPalette.indigo
		
		self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: ColorPalette.white]
		self.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: ColorPalette.white]
		
        self.navigationBar.prefersLargeTitles = true
	}

	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}

}
