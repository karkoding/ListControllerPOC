//
//  SectionListControllerTests.swift
//  KarthikTests
//
//  Created by Karthik K Manoj on 08/03/23.
//

import XCTest
@testable import ListControllerPOC

final class SectionListControllerTests: XCTestCase {
    func test_init_deliversEmpty() {
        let sut = makeSUT(cellControllers: [])
        
        XCTAssertTrue(sut.cellControllers.isEmpty)
    }
    
    func test_init_deliversSingleController() {
        let sut = makeSUT(cellControllers: [ItemCellControllerSpy()])
        
        XCTAssertEqual(sut.cellControllers.count, 1)
    }
    
    func test_init_deliversMultipleControllers() {
        let sut = makeSUT(cellControllers: [makeItemCellController(), makeItemCellController()])
        
        XCTAssertEqual(sut.cellControllers.count, 2)
    }
    
    func test_numberOfSection_deliversOneForSingleItem() {
        let sut = makeSUT(cellControllers: [makeItemCellController()])
        
        XCTAssertEqual(sut.numberOfSections(in: UITableView()), 1, "Expected 1 section.")
    }
    
    func test_numberOfSection_deliversOneForMultipleItems() {
        let sut = makeSUT(cellControllers: [makeItemCellController(), makeItemCellController()])
        
        XCTAssertEqual(sut.numberOfSections(in: UITableView()), 1, "Expected 1 section.")
    }
    
    func test_numberOfRowsInSection_deliversOneForSingleItem() {
        let sut = makeSUT(cellControllers: [makeItemCellController()])
        
        XCTAssertEqual(sut.tableView(UITableView(), numberOfRowsInSection: section), 1, "Expected 1 item.")
    }
    
    func test_numberOfRowsInSection_deliversTwoForTwoItems() {
        let sut = makeSUT(cellControllers: [makeItemCellController(), makeItemCellController()])
        
        XCTAssertEqual(sut.tableView(UITableView(), numberOfRowsInSection: section), 2, "Expected 2 items.")
    }
    
    func test_cellForRowAt_deliversCellForItems() {
        let givenCell1 = UITableViewCell()
        let givenCell2 = UITableViewCell()
        let sut = makeSUT(
            cellControllers: [
                makeItemCellController(cell: givenCell1),
                makeItemCellController(cell: givenCell2)
            ]
        )
        
        let receivedCell1 = sut.tableView(UITableView(), cellForRowAt: IndexPath(row: 0, section: section))
        let receivedCell2 = sut.tableView(UITableView(), cellForRowAt: IndexPath(row: 1, section: section))
        
        XCTAssertEqual(receivedCell1, givenCell1, "Expected received cell to match first given cell.")
        XCTAssertEqual(receivedCell2, givenCell2, "Expected received cell to match second given cell.")
    }
    
    func test_viewForHeaderInSection_deliversHeaderView() {
        let givenHeaderView = UIView()
        let sut = makeSUT(headerController: makeSectionHeaderFooterController(headerView: givenHeaderView))
                          
        let receivedHeaderView = sut.tableView(UITableView(), viewForHeaderInSection: section)
        
        XCTAssertEqual(receivedHeaderView, givenHeaderView)
    }
    
    func test_viewForHeaderInSection_doesNotDeliverHeaderView() {
        let sut = makeSUT(headerController: nil)

        XCTAssertNil(sut.tableView(UITableView(), viewForHeaderInSection: section))
    }

    func test_heightForHeaderInSection_deliversZero() {
        let sut = makeSUT(headerController: nil)

        XCTAssertEqual(sut.tableView(UITableView(), heightForHeaderInSection: section), 0)
    }

    func test_heightForHeaderInSection_deliversAutomaticDimension() {
        let sut = makeSUT(headerController: makeSectionHeaderFooterController(headerView: UIView()))

        XCTAssertEqual(sut.tableView(UITableView(), heightForHeaderInSection: section), UITableView.automaticDimension)
    }

    func test_viewForFooterInSection_deliversFooterView() {
        let givenFooterView = UIView()
        let sut = makeSUT(footerController: makeSectionHeaderFooterController(footerView: givenFooterView))
        
        let receivedFooterView = sut.tableView(UITableView(), viewForFooterInSection: section)
        
        XCTAssertEqual(receivedFooterView, givenFooterView)
    }

    func test_viewForFooterInSection_doesNotDeliverFooterView() {
        let sut = makeSUT(footerController: nil)

        XCTAssertNil(sut.tableView(UITableView(), viewForFooterInSection: section))
    }

    func test_heightForFooterInSection_deliversZero() {
        let sut = makeSUT(footerController: nil)

        XCTAssertEqual(sut.tableView(UITableView(), heightForFooterInSection: section), 0)
    }

    func test_heightForFooterInSection_deliversAutomaticDimension() {
        let sut = makeSUT(footerController: makeSectionHeaderFooterController(footerView: UIView()))

        XCTAssertEqual(sut.tableView(UITableView(), heightForFooterInSection: section), UITableView.automaticDimension)
    }

    func test_didSelectRowAt_requestsDidSelectOnce() {
        let cellController = makeItemCellController()
        let sut = makeSUT(cellControllers: [cellController])

        sut.tableView(UITableView(), didSelectRowAt: IndexPath(row: 0, section: section))

        XCTAssertEqual(cellController.didSelectCount, 1)
    }

    func test_didDeselectRowAt_requestsDidDeselectOnce() {
        let cellController = makeItemCellController()
        let sut = makeSUT(cellControllers: [cellController])

        sut.tableView(UITableView(), didDeselectRowAt: IndexPath(row: 0, section: section))

        XCTAssertEqual(cellController.didDeselectCount, 1)
    }
}

private extension SectionListControllerTests {
    var section: Int { .zero }
    
    func makeSUT(
        cellControllers: [CellController] = [],
        headerController: SectionHeaderController? = nil,
        footerController: SectionFooterController? = nil,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> SectionListController {
        let sut = SectionListController(
            cellControllers: cellControllers,
            headerController: headerController,
            footerController: footerController
        )
        trackForMemoryLeak(sut, file: file, line: line)
        return sut
    }
    
    func makeItemCellController(cell: UITableViewCell = UITableViewCell()) -> ItemCellControllerSpy {
        ItemCellControllerSpy(cell: cell)
    }
    
    func makeSectionHeaderFooterController(
        headerView: UIView = UIView(),
        footerView: UIView = UIView()
    ) -> SectionHeaderFooterControllerStub {
        SectionHeaderFooterControllerStub(headerView: headerView, footerView: footerView)
    }
        
    final class SectionHeaderFooterControllerStub: SectionHeaderController, SectionFooterController {
        let headerView: UIView
        let footerView: UIView
        
        init(headerView: UIView = UIView(), footerView: UIView = UIView()) {
            self.headerView = headerView
            self.footerView = footerView
        }
        
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? { headerView }
        
        func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? { footerView }
    }
}
