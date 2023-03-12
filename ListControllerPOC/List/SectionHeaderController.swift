//
//  SectionHeaderController.swift
//  Karthik
//
//  Created by Karthik K Manoj on 10/03/23.
//

import UIKit

/// Interface to manage a section header view in a table view.
public protocol SectionHeaderController {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
}
