//
//  ItemCellControllerSpy.swift
//  KarthikTests
//
//  Created by Karthik K Manoj on 09/03/23.
//

import UIKit
import ListControllerPOC

final class ItemCellControllerSpy: NSObject, CellController {
    let cell: UITableViewCell
    
    private(set) var didSelectCount = 0
    private(set) var didDeselectCount = 0
    
    init(cell: UITableViewCell = UITableViewCell()) {
        self.cell = cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 1 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { cell }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { didSelectCount += 1 }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) { didDeselectCount += 1 }
}
