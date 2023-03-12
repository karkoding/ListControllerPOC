//
//  ListViewController.swift
//  ListControllerPOC
//
//  Created by Karthik K Manoj on 08/03/23.
//

import UIKit

public final class ListViewController: UITableViewController {
    private var cachedSectionControllerDict: [Int: SectionController] = [:]
    
    private var tableModel = [SectionController]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    public var onLoad: (() -> Void)?
    public var configureListView: ((UITableView) -> Void)?
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        configureListView?(tableView)
        onLoad?()
    }
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        tableModel.reduce(0) { $0 + ($1.numberOfSections?(in: tableView) ?? 1) }
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sectionController(forSection: section, in: tableView).tableView(tableView, numberOfRowsInSection: section)
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        sectionController(forSection: indexPath.section, in: tableView).tableView(tableView, cellForRowAt: indexPath)
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sectionController(forSection: indexPath.section, in: tableView).tableView?(tableView, didSelectRowAt: indexPath)
    }
    
    public override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        sectionController(forSection: indexPath.section, in: tableView).tableView?(tableView, didDeselectRowAt: indexPath)
    }
    
    public override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        sectionController(forSection: section, in: tableView).tableView?(tableView, viewForHeaderInSection: section)
    }
    
    public override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        sectionController(forSection: section, in: tableView).tableView?(tableView, viewForFooterInSection: section)
    }
    
    public override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        sectionController(forSection: section, in: tableView).tableView?(tableView, heightForHeaderInSection: section) ?? .zero
    }
    
    public override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        sectionController(forSection: section, in: tableView).tableView?(tableView, heightForFooterInSection: section) ?? .zero
    }
    
    public func display(sectionControllers: [SectionController]) {
        tableModel = sectionControllers
    }
    
    private func sectionController(forSection section: Int, in tableView: UITableView) -> SectionController {
        if let sectionController = cachedSectionControllerDict[section] { return sectionController }
        
        var sectionCount = 0
        for sectionController in tableModel {
            sectionCount += sectionController.numberOfSections?(in: tableView) ?? 1
            if section < sectionCount {
                cachedSectionControllerDict[section] = sectionController
                return sectionController
            }
        }
        
        fatalError("Trying to access non existing section controller for section \(section)")
    }
}
    
private extension ListViewController {
    func configure() {
        tableView.separatorStyle = .none
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = .zero
        }
    }
}
