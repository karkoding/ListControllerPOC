//
//  VisibilityUIComposer.swift
//  ListControllerPOC
//
//  Created by Karthik K Manoj on 12/03/23.
//

import UIKit

public final class VisibilityUIComposer {
    public static func makeVisibilityUI() -> UIViewController {
        let multiSelectionSectionController = MultiSelectionSectionController(
            sectionControllers: [
                makeSectionCellController1(),
                makeSectionCellController2()
            ])
        
        let _ = SingleSelectionSectionController(sectionControllers: [
            makeSectionCellController3()
        ])
        
        let listViewController = ListViewController()
        
        listViewController.configureListView = {
            VisibilityCellController.configure(tableView: $0)
            VisibilityHeaderController.configure(tableView: $0)
        }
        
        // It works with one section
       // listViewController.display(sectionControllers: [singleSelectionSectionController])
        
        // It crashes with multiple sections
        // listViewController.display(sectionControllers: [multiSelectionSectionController, singleSelectionSectionController])
        
        // It works with one section
        listViewController.display(sectionControllers: [multiSelectionSectionController])
        
        return listViewController
    }
    
    private static func makeSectionCellController1() -> SectionController {
        let visibilityHeaderController = VisibilityHeaderController(title: "Visibility 1 (Multi Selection)")
        
        let visibilityList = VisibilityLevel.allCases
        let visibilityCellControllers = visibilityList.map {
            let viewModel = VisibilityCellViewModel(model: $0)
            let visibilityCellController = VisibilityCellController(viewModel: viewModel)
            return visibilityCellController
        }
        
        let sectionController = SectionListController(
            cellControllers: visibilityCellControllers,
            headerController: visibilityHeaderController
        )
        
        return sectionController
    }
    
    private static func makeSectionCellController2() -> SectionController {
        let visibilityHeaderController = VisibilityHeaderController(title: "Visibility 2 (Multi Selection)")
        
        let visibilityList = VisibilityLevel.allCases
        let visibilityCellControllers = visibilityList.map {
            let viewModel = VisibilityCellViewModel(model: $0)
            let visibilityCellController = VisibilityCellController(viewModel: viewModel)
            return visibilityCellController
        }
        
        let sectionController = SectionListController(
            cellControllers: visibilityCellControllers,
            headerController: visibilityHeaderController
        )
        
        return sectionController
    }
    
    private static func makeSectionCellController3() -> SectionController {
        let visibilityHeaderController = VisibilityHeaderController(title: "Visibility 3 (Single Selection)")
        
        let visibilityList = VisibilityLevel.allCases
        let visibilityCellControllers = visibilityList.map {
            let viewModel = VisibilityCellViewModel(model: $0)
            let visibilityCellController = VisibilityCellController(viewModel: viewModel)
            return visibilityCellController
        }
        
        let sectionController = SectionListController(
            cellControllers: visibilityCellControllers,
            headerController: visibilityHeaderController
        )
        
        return sectionController
    }
}
