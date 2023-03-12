//
//  VisibilityHeaderControllerTests.swift
//  KarthikTests
//
//  Created by Karthik K Manoj on 12/03/23.
//

import Foundation

import XCTest
@testable import ListControllerPOC

final class VisibilityHeaderControllerTests: XCTestCase {
    func test_configure_dequeueViewDeliversVisibilityHeaderView() {
        let tableView = configureTableView()
        
        XCTAssertTrue(tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: VisibilityHeaderView.self)) is VisibilityHeaderView)
    }
    
    func test_viewForHeaderInSection_deliversVisibilityHeaderView() {
        let tableView = configureTableView()
        let sut = makeSUT()
        
        let headerView = sut.tableView(tableView, viewForHeaderInSection: 0)
        
        XCTAssertTrue(headerView is VisibilityHeaderView)
        XCTAssertEqual(try XCTUnwrap(headerView as? VisibilityHeaderView).titleLabel.text, "VISIBILITY")
    }
}

private extension VisibilityHeaderControllerTests {
    func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> VisibilityHeaderController {
        let sut = VisibilityHeaderController()
        trackForMemoryLeak(sut, file: file, line: line)
        return sut
    }
    
    func configureTableView() -> UITableView {
        let tableView = UITableView()
        VisibilityHeaderController.configure(tableView: tableView)
        return tableView
    }
}
