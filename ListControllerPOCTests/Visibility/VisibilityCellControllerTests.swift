//
//  VisibilityCellControllerTests.swift
//  ListControllerPOCTests
//
//  Created by Karthik K Manoj on 10/03/23.
//

import XCTest
@testable import ListControllerPOC

final class VisibilityCellControllerTests: XCTestCase {
    func test_init_deliversViewModel() {
        let viewModel = makeVisibilityCellViewModel()
        let sut = makeSUT(viewModel: viewModel)
        
        XCTAssertEqual(sut.viewModel, viewModel)
    }
    
    func test_configure_dequeueCellDeliversVisibilityCell() {
        let tableView = configureTableView()
        
        XCTAssertTrue(tableView.dequeueReusableCell(withIdentifier: String(describing: VisibilityCell.self)) is VisibilityCell)
    }
    
    func test_numberOfRowsInSection_deliversOne() {
        let sut = makeSUT(viewModel: makeVisibilityCellViewModel())
        
        XCTAssertEqual(sut.tableView(UITableView(), numberOfRowsInSection: .zero), 1)
    }
    
    func test_cellForRowAt_deliversVisibilityCell() {
        let sut = makeSUT(viewModel: makeVisibilityCellViewModel())
        
        let cell = sut.tableView(configureTableView(), cellForRowAt: indexPath)
        
        XCTAssertTrue(cell is VisibilityCell)
    }
    
    func test_cellForRowAt_deliversCellContentForPublishedState() {
        let viewModel = makeVisibilityCellViewModel(model: .published)
        let sut = makeSUT(viewModel: viewModel)
        
        let visibilityCell = sut.tableView(
            configureTableView(),
            cellForRowAt: indexPath
        ) as? VisibilityCell
        
        XCTAssertEqual(
            visibilityCell?.iconImage?.pngData(),
            getImage(named: "published").pngData(),
            "Expected to render published image."
        )
        
        XCTAssertEqual(visibilityCell?.titleText, "Published", "Expected to render title text as Published.")
        XCTAssertNil(visibilityCell?.checkmarkImage, "Expected no checkmark image.")
    }
    
    func test_cellForRowAt_deliversCellContentForUnpublishedState() {
        let viewModel = makeVisibilityCellViewModel(model: .unpublished)
        let sut = makeSUT(viewModel: viewModel)

        let visibilityCell = sut.tableView(
            configureTableView(),
            cellForRowAt: indexPath
        ) as? VisibilityCell

        XCTAssertEqual(
            visibilityCell?.iconImage?.pngData(),
            getImage(named: "unpublished").pngData(),
            "Expected to render unpublished image."
        )
        
        XCTAssertEqual(visibilityCell?.titleText, "Unpublished", "Expected to render title text as Unpublished.")
        XCTAssertNil(visibilityCell?.checkmarkImage, "Expected no checkmark image.")
    }
    
    func test_didSelectRowAt_rendersCellContentWithCheckmark_forPublishedState() {
        let tableView =  configureTableView()
        let viewModel = makeVisibilityCellViewModel(model: .published)
        let sut = makeSUT(viewModel: viewModel)

        let visibilityCell = sut.tableView(
            tableView,
            cellForRowAt: indexPath
        ) as? VisibilityCell
        
        sut.tableView(tableView, didSelectRowAt: indexPath)
        
        XCTAssertEqual(
            visibilityCell?.iconImage?.pngData(),
            getImage(named: "published").pngData(),
            "Expected to render published image after selection."
        )
        
        XCTAssertEqual(
            visibilityCell?.titleText,
            "Published",
            "Expected to render title text as Published after selection."
        )
        
        XCTAssertEqual(
            visibilityCell?.checkmarkImage?.pngData(),
            getImage(named: "checkmark").pngData(),
            "Expected to render checkmark image after selection"
        )
    }
    
    func test_didSelectRowAt_rendersCellContentWithCheckmark_forUnpublishedState() {
        let tableView =  configureTableView()
        let viewModel = makeVisibilityCellViewModel(model: .unpublished)
        let sut = makeSUT(viewModel: viewModel)

        let visibilityCell = sut.tableView(
            tableView,
            cellForRowAt: indexPath
        ) as? VisibilityCell
        
        sut.tableView(tableView, didSelectRowAt: indexPath)
        
        XCTAssertEqual(
            visibilityCell?.iconImage?.pngData(),
            getImage(named: "unpublished").pngData(),
            "Expected to render unpublished image after selection."
        )
        
        XCTAssertEqual(
            visibilityCell?.titleText,
            "Unpublished",
            "Expected to render title text as Unpublished after selection."
        )
        
        XCTAssertEqual(
            visibilityCell?.checkmarkImage?.pngData(),
            getImage(named: "checkmark").pngData(),
            "Expected to render checkmark image after selection."
        )
    }
    
    func test_didSelectRowAtTwice_rendersWithoutCheckmark_forPublishedState() {
        let tableView =  configureTableView()
        let viewModel = makeVisibilityCellViewModel(model: .published)
        let sut = makeSUT(viewModel: viewModel)

        let visibilityCell = sut.tableView(
            tableView,
            cellForRowAt: indexPath
        ) as? VisibilityCell
        
        XCTAssertNil(visibilityCell?.checkmarkImage?.pngData(), "Expected no checkmark before selection.")
        
        sut.tableView(tableView, didSelectRowAt: indexPath)
        
        XCTAssertEqual(
            visibilityCell?.checkmarkImageView.image?.pngData(),
            getImage(named: "checkmark").pngData(),
            "Expected to render checkmark image on first selection."
        )
        
        sut.tableView(tableView, didSelectRowAt: indexPath)
        
        XCTAssertNil(
            visibilityCell?.checkmarkImageView.image?.pngData(),
            "Expected no checkmark image on second selection."
        )
    }
    
    func test_didSelectRowAtTwice_rendersWithoutCheckmark_forUnpublishedState() {
        let tableView =  configureTableView()
        let viewModel = makeVisibilityCellViewModel(model: .unpublished)
        let sut = makeSUT(viewModel: viewModel)

        let visibilityCell = sut.tableView(
            tableView,
            cellForRowAt: indexPath
        ) as? VisibilityCell
        
        XCTAssertNil(
            visibilityCell?.checkmarkImageView.image?.pngData(),
            "Expected no checkmark image before selection."
        )
        
        sut.tableView(tableView, didSelectRowAt: indexPath)
        
        XCTAssertEqual(
            visibilityCell?.checkmarkImageView.image?.pngData(),
            getImage(named: "checkmark").pngData(),
            "Expected to render checkmark image on first selection."
        )
        
        sut.tableView(tableView, didSelectRowAt: indexPath)
        
        XCTAssertNil(
            visibilityCell?.checkmarkImageView.image?.pngData(),
            "Expected no checkmark image on second selection."
        )
    }
    
    func test_cellForRowAt_reuseCellRendersUpdatedData() {
        let tableView = configureTableView()
        let viewModel = makeVisibilityCellViewModel(model: .unpublished)
        let sut = makeSUT(viewModel: viewModel)

        let visibilityCell = sut.tableView(
            tableView,
            cellForRowAt: indexPath
        ) as? VisibilityCell

        sut.tableView(tableView, didSelectRowAt: indexPath)
        
        XCTAssertEqual(
            visibilityCell?.iconImage?.pngData(),
            getImage(named: "unpublished").pngData(),
            "Expected to render unpublished image."
        )
        
        XCTAssertEqual(
            visibilityCell?.titleText,
            "Unpublished",
            "Expected to render title text as Unpublished."
        )
        
        XCTAssertEqual(
            visibilityCell?.checkmarkImageView.image?.pngData(),
            getImage(named: "checkmark").pngData(),
            "Expected to render checkmark image."
        )
        
        let latestViewModel = makeVisibilityCellViewModel(model: .published)
        visibilityCell?.configure(latestViewModel)
        
        XCTAssertEqual(
            visibilityCell?.iconImage?.pngData(),
            getImage(named: "published").pngData(),
            "Expected to render published image."
        )
        
        XCTAssertEqual(
            visibilityCell?.titleText,
            "Published",
            "Expected to render title text as Published."
        )
        
        XCTAssertNil(visibilityCell?.checkmarkImageView.image, "Expected no checkmark image.")
    }
}

private extension VisibilityCellControllerTests {
    var indexPath: IndexPath { IndexPath(row: .zero, section: .zero) }
    
    func makeSUT(
        viewModel: VisibilityCellViewModel,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> VisibilityCellController {
        let sut = VisibilityCellController(viewModel: viewModel)
        trackForMemoryLeak(sut, file: file, line: line)
        return sut
    }
    
    func makeVisibilityCellViewModel(
        model: VisibilityLevel = .published,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> VisibilityCellViewModel {
        let viewModel = VisibilityCellViewModel(model: model)
        trackForMemoryLeak(viewModel, file: file, line: line)
        return viewModel
    }
    
    func configureTableView() -> UITableView {
        let tableView = UITableView()
        VisibilityCellController.configure(tableView: tableView)
        return tableView
    }
    
    func getImage(named: String, file: StaticString = #filePath, line: UInt = #line) -> UIImage {
        guard let image = UIImage(named: named) else {
            XCTFail("Expected to get an image using \(named), but failed.", file: file, line: line)
            return UIImage()
        }
        
        return image
    }
}

private extension VisibilityCell {
    var titleText: String {
        titleLabel.text!
    }
    
    var iconImage: UIImage? {
        iconImageView.image
    }
    
    var checkmarkImage: UIImage? {
        checkmarkImageView.image
    }
}

extension VisibilityCellViewModel: Equatable {
    public static func == (lhs: ListControllerPOC.VisibilityCellViewModel, rhs: ListControllerPOC.VisibilityCellViewModel) -> Bool {
        lhs === rhs
    }
}
