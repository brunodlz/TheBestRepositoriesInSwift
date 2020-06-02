import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		window = UIWindow(frame: UIScreen.main.bounds)
		
		let apiService = APIService()
		let datasource = RepositoryDataSource()
		let viewModel = RepositoryViewModel(service: apiService, datasource: datasource)
		
		let repositoryViewController = RepositoryViewController(viewModel: viewModel)
		window?.rootViewController = BaseNavigationController(rootViewController: repositoryViewController)
        window?.makeKeyAndVisible()
		
		statusBarChangeColor()
		
		return true
	}
	
	private func statusBarChangeColor() {
		let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
		
		if let statusBarFrame = keyWindow?.windowScene?.statusBarManager?.statusBarFrame {
			let statusBar = UIView(frame: statusBarFrame)
			statusBar.backgroundColor = ColorPalette.indigo
			keyWindow?.addSubview(statusBar)
		}
	}

}
