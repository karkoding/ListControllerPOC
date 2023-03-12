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
        
        let sectionController2 = SectionListController(
            cellControllers: visibilityCellControllers,
            headerController: visibilityHeaderController
        )
        
        let listViewController = ListViewController()
        
        listViewController.configureListView = {
            VisibilityCellController.configure(tableView: $0)
            VisibilityHeaderController.configure(tableView: $0)
        }
        
        listViewController.display(sectionControllers: [sectionController])
        
        return listViewController
    }
}
