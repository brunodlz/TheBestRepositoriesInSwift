import UIKit

final class RepositoryDataSource: GenericDataSource<GitHub>, UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if data.value.count > 0 {
			let whiteView = UIView()
			whiteView.backgroundColor = .white
			
			tableView.separatorStyle = .singleLine
			tableView.backgroundView = whiteView
		} else {
			let spinner = UIActivityIndicatorView()
			spinner.center = tableView.center
			spinner.startAnimating()
			
			tableView.separatorStyle = .none
			tableView.backgroundView = spinner
		}
		
		return data.value.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: RepositoryCell = tableView.dequeueReusable(for: indexPath)

		let repository = self.data.value[indexPath.row]
		cell.configure(repository)

		return cell
	}

}
