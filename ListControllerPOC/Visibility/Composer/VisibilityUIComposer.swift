//
//  VisibilityUIComposer.swift
//  ListControllerPOC
//
//  Created by Karthik K Manoj on 12/03/23.
//

import UIKit

public final class VisibilityUIComposer {
    public static func makeVisibilityUI() -> UIViewController {
        let visibilityHeaderController = VisibilityHeaderController()
        
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
        
        let multiSelectionSectionController = MultiSelectionSectionController(sectionControllers: [sectionController])
        
        let listViewController = ListViewController()
        
        listViewController.configureListView = {
            VisibilityCellController.configure(tableView: $0)
            VisibilityHeaderController.configure(tableView: $0)
        }
        
        listViewController.display(sectionControllers: [multiSelectionSectionController])
        
        return listViewController
    }
}
