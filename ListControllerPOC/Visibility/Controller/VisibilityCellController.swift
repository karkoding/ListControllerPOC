//
//  VisibilityCellController.swift
//  Karthik
//
//  Created by Karthik K Manoj on 10/03/23.
//

import UIKit

final class VisibilityCellController: NSObject {
    let viewModel: VisibilityCellViewModel
    
    init(viewModel: VisibilityCellViewModel) {
        self.viewModel = viewModel
    }
    
    static func configure(tableView: UITableView) {
        tableView.register(VisibilityCell.self, forCellReuseIdentifier: String(describing: VisibilityCell.self))
    }
}

extension VisibilityCellController: CellController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 1 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: VisibilityCell.self)) as! VisibilityCell
        cell.configure(viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.updateSelection()
    }
}
