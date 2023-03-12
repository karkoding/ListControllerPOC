//
//  SingleSelectionSectionController.swift
//  ListControllerPOC
//
//  Created by Karthik K Manoj on 12/03/23.
//

import UIKit

public final class SingleSelectionSectionController: NSObject {
    private var selectedIndexPath: IndexPath?
    private var selectedSectionController: SectionController?
    let sectionControllers: [SectionController]
    
    public init(sectionControllers: [SectionController]) {
        self.sectionControllers = sectionControllers
    }
}

extension SingleSelectionSectionController: SectionController {
    public func numberOfSections(in tableView: UITableView) -> Int {
        sectionControllers.reduce(0) { $0 + ($1.numberOfSections?(in: tableView) ?? 1) }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { sectionControllers[section].tableView(tableView, numberOfRowsInSection: section)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        sectionControllers[indexPath.section].tableView(tableView, cellForRowAt: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedIndexPath = selectedIndexPath,
                 let selectedSectionController = selectedSectionController else {
            self.selectedIndexPath = indexPath
            self.selectedSectionController = sectionControllers[indexPath.section]
            selectedSectionController?.tableView?(tableView, didSelectRowAt: indexPath)
            return
        }

        selectedSectionController.tableView?(tableView, didDeselectRowAt: selectedIndexPath)
        sectionControllers[indexPath.section].tableView?(tableView, didSelectRowAt: indexPath)

        self.selectedIndexPath = indexPath
        self.selectedSectionController = sectionControllers[indexPath.section]
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        sectionControllers[section].tableView?(tableView, viewForHeaderInSection: section)
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        sectionControllers[section].tableView?(tableView, viewForFooterInSection: section)
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        sectionControllers[section].tableView?(tableView, heightForHeaderInSection: section) ?? .zero
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        sectionControllers[section].tableView?(tableView, heightForFooterInSection: section) ?? .zero
    }
}
