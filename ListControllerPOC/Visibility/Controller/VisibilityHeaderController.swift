//
//  VisibilityHeaderController.swift
//  ListControllerPOC
//
//  Created by Karthik K Manoj on 12/03/23.
//

import UIKit

final class VisibilityHeaderController {
    private let title: String
    
    init(title: String) {
        self.title = title
    }
    
    static func configure(tableView: UITableView) {
        tableView.register(
            VisibilityHeaderView.self,
            forHeaderFooterViewReuseIdentifier: String(describing: VisibilityHeaderView.self)
        )
    }
}

extension VisibilityHeaderController: SectionHeaderController {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let visiblityHeaderView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: String(describing: VisibilityHeaderView.self)
        ) as! VisibilityHeaderView
        
        visiblityHeaderView.titleLabel.text = title
        return visiblityHeaderView
    }
}
