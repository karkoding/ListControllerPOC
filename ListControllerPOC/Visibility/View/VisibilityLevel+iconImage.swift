//
//  VisibilityLevel+iconImage.swift
//  Karthik
//
//  Created by Karthik K Manoj on 12/03/23.
//

import UIKit

extension VisibilityLevel {
    var iconImage: UIImage {
        let image: UIImage?
        switch self {
        case .published:
            image = VisibilityImage.published.image
        case .unpublished:
            image = VisibilityImage.unpublished.image
        }
        
        return image ?? UIImage()
    }
}
