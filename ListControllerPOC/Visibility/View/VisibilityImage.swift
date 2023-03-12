//
//  VisibilityImage.swift
//  ListControllerPOC
//
//  Created by Karthik K Manoj on 12/03/23.
//

import UIKit

enum VisibilityImage: String {
    case published
    case unpublished
    case checkmark
    
    var image: UIImage? {
        UIImage(named: rawValue)
    }
}
