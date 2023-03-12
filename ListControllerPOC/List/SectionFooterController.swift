//
//  SectionFooterController.swift
//  ListControllerPOC
//
//  Created by Karthik K Manoj on 10/03/23.
//

import UIKit

/// Interface to manage a section footer view in a table view.
public protocol SectionFooterController {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
}
