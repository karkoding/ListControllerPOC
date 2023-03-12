//
//  VisibilityHeaderController.swift
//  Karthik
//
//  Created by Karthik K Manoj on 12/03/23.
//

import UIKit

final class VisibilityHeaderController {
    static func configure(tableView: UITableView) {
        tableView.register(
            VisibilityHeaderView.self,
            forHeaderFooterViewReuseIdentifier: String(describing: VisibilityHeaderView.self)
        )
    }
}

extension VisibilityHeaderController: SectionHeaderController {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: VisibilityHeaderView.self))
    }
}
