import XCTest

@testable import Stars

class RepositoryDataSourceTests: XCTestCase {

	var datasource: RepositoryDataSource!
	
	override func setUp() {
		super.setUp()
		
		datasource = RepositoryDataSource()
	}
	
	override func tearDown() {
		datasource = nil
		
		super.tearDown()
	}
	
	func testEmptyValueDatasource() {
		datasource.data.value = []
		
		let tableView = UITableView()
		tableView.dataSource = datasource
		
		XCTAssertEqual(datasource.numberOfSections(in: tableView), 1,
					   "Should contain one section in the table view")
		
		XCTAssertEqual(datasource.tableView(tableView, numberOfRowsInSection: 0), 0,
					   "Should contain no cell in the table view")
	}
	
	func testValueInDatasource() {
		let mock1 = RepositoryDataSourceTests.mock1
		let mock2 = RepositoryDataSourceTests.mock2
		
		datasource.data.value = [mock1, mock2]
		
		let tableView = UITableView()
		tableView.dataSource = datasource
		
		XCTAssertEqual(datasource.numberOfSections(in: tableView), 1,
					   "Should contain one section in table view")
		
		XCTAssertEqual(datasource.tableView(tableView, numberOfRowsInSection: 2), 2,
					   "Should contain two cells in the table view")
	}
	
	func testValueCell() {
		let mock = RepositoryDataSourceTests.mock1
		datasource.data.value = [mock]
		
		let tableView = UITableView()
		tableView.dataSource = datasource
		tableView.register(RepositoryCell.self)
		
		let indexPath = IndexPath(row: 0, section: 0)
		
		guard let _ = datasource.tableView(tableView, cellForRowAt: indexPath) as? RepositoryCell else {
			XCTAssert(false, "Should be 'RepositoryCell' class")
			return
		}
	}
	
}

extension RepositoryDataSourceTests {
	
	static let mock1: GitHub = {
		let user1 = User(name: "User Test", avatar: "mockurl.com")
		return GitHub(repositoryName: "Test 1", stars: 10, user: user1)
	}()
	
	static let mock2: GitHub = {
		let user2 = User(name: "User Test 2", avatar: "mockurl2.com")
		return GitHub(repositoryName: "Test 2", stars: 20, user: user2)
	}()
	
}
