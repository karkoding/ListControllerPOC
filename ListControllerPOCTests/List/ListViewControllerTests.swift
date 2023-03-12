//
//  ListViewControllerTests.swift
//  ListControllerPOCTests
//
//  Created by Karthik K Manoj on 08/03/23.
//

import XCTest
import ListControllerPOC

final class ListViewControllerTests: XCTestCase {
    func test_viewDidLoad_messagesOnLoadOnce() {
        let sut = makeSUT()
        
        var callCount = 0
        sut.onLoad = { callCount += 1 }
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(callCount, 1)
    }
    
    func test_viewDidLoad_messagesConfigureListViewOnce() {
        let sut = makeSUT()
        
        var callCount = 0
        sut.configureListView = { _ in callCount += 1 }
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(callCount, 1)
    }
    
    func test_viewDidLoad_defaultValues() {
        let sut = makeSUT()
        
        sut.loadViewIfNeeded()
        
        XCTAssertFalse(sut.isSeparatorLineVisible)
        XCTAssertEqual(sut.sectionHeaderTopPadding, .zero)
    }
    
    func test_configureListView_overridesDefaultValues() {
        let sut = makeSUT()
    
        sut.configureListView = {
            $0.separatorStyle = .singleLine
        }
        
        sut.loadViewIfNeeded()
        
        XCTAssertTrue(sut.isSeparatorLineVisible)
    }
    
    func test_display_deliversNumberOfSections() {
        let sut = makeSUT()
        
        sut.display(sectionControllers: [])
        
        XCTAssertEqual(sut.numberOfSections, 0, "Expected no section.")
        
        sut.display(sectionControllers: [makeSingleItemSectionController()])
        
        XCTAssertEqual(sut.numberOfSections, 1, "Expected 1 section.")
        
        sut.display(sectionControllers: [makeSingleItemSectionController(), makeSingleItemSectionController()])
        
        XCTAssertEqual(sut.numberOfSections, 2, "Expected 2 sections.")
    }
    
    func test_display_deliversNumberOfItemsPerSection() {
        let sut = makeSUT()
        
        sut.display(
            sectionControllers: [
                makeSingleItemSectionController(),
                makeSingleItemSectionController(),
                makeSingleItemSectionController()
            ]
        )
        
        XCTAssertEqual(sut.numberOfSections, 3, "Expected 3 sections.")
        XCTAssertEqual(sut.numberOfItemsInSection(section: 0), 1, "Expected single item for section 0.")
        XCTAssertEqual(sut.numberOfItemsInSection(section: 1), 1, "Expected single item for section 1.")
        XCTAssertEqual(sut.numberOfItemsInSection(section: 2), 1, "Expected single item for section 2.")
    }
    
    func test_displayWithMultipleItems_rendersMultipleItems() {
        let sut = makeSUT()
        let givenCell1 = UITableViewCell()
        let givenCell2 = UITableViewCell()
        let cellController1 = makeItemCellController(cell: givenCell1)
        let cellController2 = makeItemCellController(cell: givenCell2)
        
        sut.display(
            sectionControllers: [
                makeSingleItemSectionController(cellController: cellController1),
                makeSingleItemSectionController(cellController: cellController2)
            ]
        )
        
        let receivedCell1 = sut.simulateItemVisibile(at: 0, forSection: 0)
        let receivedCell2 = sut.simulateItemVisibile(at: 1, forSection: 1)
    
        XCTAssertEqual(receivedCell1, givenCell1)
        XCTAssertEqual(receivedCell2, givenCell2)
    }
    
    func test_displayWithMultipleItems_rendersHeaderViewPerSection() {
        let sut = makeSUT()
        let givenHeaderView1 = UIView()
        let givenHeaderView2 = UIView()
        let cellController1 = makeItemCellController()
        let cellController2 = makeItemCellController()
        
        let sectionController1 = makeSingleItemSectionController(
            cellController: cellController1,
            headerView: givenHeaderView1
        )
        let sectionController2 = makeSingleItemSectionController(
            cellController: cellController2,
            headerView: givenHeaderView2
        )
        
        sut.display(sectionControllers: [sectionController1, sectionController2])
        
        let receivedHeaderView1 = sut.simulateItemHeaderViewVisible(at: 0)
        let receivedHeaderView2 = sut.simulateItemHeaderViewVisible(at: 1)
        
        XCTAssertEqual(
            receivedHeaderView1,
            givenHeaderView1,
            "Expected header view to match first header view."
        )
        XCTAssertEqual(
            receivedHeaderView2,
            givenHeaderView2,
            "Expected header view to match second header view."
        )
    }
    
    func test_displayWithMultipleItems_rendersFooterViewPerSection() {
        let sut = makeSUT()
        let givenFooterView1 = UIView()
        let givenFooterView2 = UIView()
        let cellController1 = makeItemCellController()
        let cellController2 = makeItemCellController()
        let sectionController1 = makeSingleItemSectionController(
            cellController: cellController1,
            footerView: givenFooterView1
        )
        let sectionController2 = makeSingleItemSectionController(
            cellController: cellController2,
            footerView: givenFooterView2
        )
        
        sut.display(sectionControllers: [sectionController1, sectionController2])
        
        let receivedFooterView1 = sut.simulateItemFooterViewVisible(at: 0)
        let receivedFooterView2 = sut.simulateItemFooterViewVisible(at: 1)
        
        XCTAssertEqual(
            receivedFooterView1,
            givenFooterView1,
            "Expected footer view to match first footer view."
        )
        
        XCTAssertEqual(
            receivedFooterView2,
            givenFooterView2,
            "Expected footer view to match second footer view."
        )
    }
    
    func test_headerViewHeight_deliversHeaderViewHeight() {
        let sut = makeSUT()
        
        sut.display(sectionControllers: [makeSingleItemSectionController(headerViewHeight: 10)])
        
        XCTAssertEqual(sut.headerViewHeight(forSection: 0), 10.0)
    }
    
    func test_footerViewHeight_deliversFooterViewHeight() {
        let sut = makeSUT()
        
        sut.display(sectionControllers: [makeSingleItemSectionController(footerViewHeight: 20)])
        
        XCTAssertEqual(sut.footerViewHeight(forSection: 0), 20.0)
    }
    
    func test_displayTwice_deliversLatestItems() {
        let sut = makeSUT()
       
        sut.display(sectionControllers: [makeSingleItemSectionController()])
    
        XCTAssertEqual(sut.numberOfRenderedSections, 1, "Expected to render 1 section.")
        XCTAssertEqual(
            sut.numberOfRenderedItemsInSection(section: 0),
            1,
            "Expected to render 1 item for first section."
        )
    
        sut.display(sectionControllers: [])
    
        XCTAssertEqual(sut.numberOfRenderedSections, 0)
    }

    func test_didSelectItem_requestsDidSelectOnce() {
        let sut = makeSUT()
        let cellController = makeItemCellController()
        let sectionController = makeSingleItemSectionController(cellController: cellController)
        
        sut.display(sectionControllers: [sectionController])
        sut.simulateDidSelectItem(at: 0, forSection: 0)
        
        XCTAssertEqual(cellController.didSelectCount, 1)
    }
    
    func test_didDeselectItem_requestsDidDeselectOnce() {
        let sut = makeSUT()
        let cellController = makeItemCellController()
        let sectionController = makeSingleItemSectionController(cellController: cellController)
        
        sut.display(sectionControllers: [sectionController])
        sut.simulateDidDeselectItem(at: 0, forSection: 0)
        
        XCTAssertEqual(cellController.didDeselectCount, 1)
    }
}

private extension ListViewControllerTests {
    func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> ListViewController {
        let sut = ListViewController()
        trackForMemoryLeak(sut, file: file, line: line)
        return sut
    }
    
    func makeSingleItemSectionController(
        cellController: CellController = ItemCellControllerSpy(),
        headerView: UIView = UIView(),
        footerView: UIView = UIView(),
        headerViewHeight: CGFloat = 0.0,
        footerViewHeight: CGFloat = 0.0
    ) -> SingleItemSectionControllerStub {
        SingleItemSectionControllerStub(
            cellController: cellController,
            headerView: headerView,
            footerView: footerView,
            headerViewHeight: headerViewHeight,
            footerViewHeight: footerViewHeight
        )
    }
    
    func makeItemCellController(cell: UITableViewCell = UITableViewCell()) -> ItemCellControllerSpy {
        ItemCellControllerSpy(cell: cell)
    }
    
    final class SingleItemSectionControllerStub: NSObject, SectionController {
        let cellController: CellController
        let headerView: UIView
        let footerView: UIView
        let headerViewHeight: CGFloat
        let footerViewHeight: CGFloat
        
        init(
            cellController: CellController,
            headerView: UIView = UIView(),
            footerView: UIView = UIView(),
            headerViewHeight: CGFloat = 0.0,
            footerViewHeight: CGFloat = 0.0
        ) {
            self.cellController = cellController
            self.headerView = headerView
            self.footerView = footerView
            self.headerViewHeight = headerViewHeight
            self.footerViewHeight = footerViewHeight
        }

        func numberOfSections(in tableView: UITableView) -> Int { 1 }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 1 }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            cellController.tableView(tableView, cellForRowAt: indexPath)
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            cellController.tableView?(tableView, didSelectRowAt: indexPath)
        }
        
        func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
            cellController.tableView?(tableView, didDeselectRowAt: indexPath)
        }
        
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? { headerView }
        
        func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? { footerView }
        
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            headerViewHeight
        }
        
        func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            footerViewHeight
        }
    }
}

private extension ListViewController {
    var isSeparatorLineVisible: Bool {
        !(tableView.separatorStyle == .none)
    }
    
    var sectionHeaderTopPadding: CGFloat {
        var padding: CGFloat = .zero
        
        if #available(iOS 15.0, *) {
            padding = tableView.sectionHeaderTopPadding
        }
        
        return padding
    }
    
    var numberOfRenderedSections: Int {
        tableView.numberOfSections
    }
    
    func numberOfRenderedItemsInSection(section: Int) -> Int? {
        tableView.numberOfRows(inSection: section)
    }
    
    var numberOfSections: Int? {
        let dataSource = tableView.dataSource
        return dataSource?.numberOfSections?(in: tableView)
    }
    
    func numberOfItemsInSection(section: Int) -> Int? {
        let dataSource = tableView.dataSource
        return dataSource?.tableView(tableView, numberOfRowsInSection: section)
    }
    
    func simulateItemVisibile(at index: Int, forSection section: Int) -> UITableViewCell? {
        let dataSource = tableView.dataSource
        let indexPath = IndexPath(item: index, section: section)
        return dataSource?.tableView(tableView, cellForRowAt: indexPath)
    }
    
    func simulateItemHeaderViewVisible(at section: Int) -> UIView? {
        let delegate = tableView.delegate
        return delegate?.tableView?(tableView, viewForHeaderInSection: section)
    }
    
    func simulateItemFooterViewVisible(at section: Int) -> UIView? {
        let delegate = tableView.delegate
        return delegate?.tableView?(tableView, viewForFooterInSection: section)
    }
    
    func simulateDidSelectItem(at index: Int, forSection section: Int) {
        let delegate = tableView.delegate
        let indexPath =  IndexPath(row: index, section: section)
        delegate?.tableView?(tableView, didSelectRowAt: indexPath)
    }
    
    func simulateDidDeselectItem(at index: Int, forSection section: Int) {
        let delegate = tableView.delegate
        let indexPath =  IndexPath(row: index, section: section)
        delegate?.tableView?(tableView, didDeselectRowAt: indexPath)
    }
    
    func headerViewHeight(forSection section: Int) -> CGFloat {
        let delegate = tableView.delegate
        return delegate?.tableView?(tableView, heightForHeaderInSection: section) ?? 0.0
    }
    
    func footerViewHeight(forSection section: Int) -> CGFloat {
        let delegate = tableView.delegate
        return delegate?.tableView?(tableView, heightForFooterInSection: section) ?? 0.0
    }
}
