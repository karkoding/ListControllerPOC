//
//  SectionListController.swift
//  Karthik
//
//  Created by Karthik K Manoj on 09/03/23.
//

import UIKit

public final class SectionListController: NSObject {
    let cellControllers: [CellController]
    let headerController: SectionHeaderController?
    let footerController: SectionFooterController?
    
    public init(
        cellControllers: [CellController],
        headerController: SectionHeaderController? = nil,
        footerController: SectionFooterController? = nil
    ) {
        self.cellControllers = cellControllers
        self.headerController = headerController
        self.footerController = footerController
    }
}

extension SectionListController: SectionController {
    public func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { cellControllers.count }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cellControllers[indexPath.row].tableView(tableView, cellForRowAt: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellControllers[indexPath.row].tableView?(tableView, didSelectRowAt: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        cellControllers[indexPath.row].tableView?(tableView, didDeselectRowAt: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerController?.tableView(tableView, viewForHeaderInSection: section)
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        footerController?.tableView(tableView, viewForFooterInSection: section)
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        headerController == nil ?  CGFloat.zero : UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        footerController == nil ?  CGFloat.zero : UITableView.automaticDimension
    }
}
