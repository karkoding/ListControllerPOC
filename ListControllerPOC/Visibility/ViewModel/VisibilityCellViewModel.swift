//
//  VisibilityCellViewModel.swift
//  ListControllerPOC
//
//  Created by Karthik K Manoj on 11/03/23.
//

import Foundation

final class VisibilityCellViewModel {
    let model: VisibilityLevel
    
    private(set) var isSelected = false {
        didSet {
            onSelection?(isSelected)
        }
    }
    
    var onSelection: ((Bool) -> Void)?
    
    var title: String {
        let title: String
        
        switch model {
        case .published:
            title = "Published"
        case .unpublished:
            title = "Unpublished"
        }
        
        return title
    }
    
    init(model: VisibilityLevel) {
        self.model = model
    }
    
    func updateSelection() {
        isSelected.toggle()
    }
}
