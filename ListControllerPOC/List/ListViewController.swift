//
//  ListViewController.swift
//  ListControllerPOC
//
//  Created by Karthik K Manoj on 08/03/23.
//

import UIKit

public final class ListViewController: UITableViewController {
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
        tableModel.count
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableModel[section].tableView(tableView, numberOfRowsInSection: section)
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableModel[indexPath.section].tableView(tableView, cellForRowAt: indexPath)
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableModel[indexPath.section].tableView?(tableView, didSelectRowAt: indexPath)
    }
    
    public override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableModel[indexPath.section].tableView?(tableView, didDeselectRowAt: indexPath)
    }
    
    public override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        tableModel[section].tableView?(tableView, viewForHeaderInSection: section)
    }
    
    public override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        tableModel[section].tableView?(tableView, viewForFooterInSection: section)
    }
    
    public override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        tableModel[section].tableView?(tableView, heightForHeaderInSection: section) ?? .zero
    }
    
    public override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        tableModel[section].tableView?(tableView, heightForFooterInSection: section) ?? .zero
    }
    
    public func display(sectionControllers: [SectionController]) {
        tableModel = sectionControllers
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
