//
//  RoundedViewTheme.swift
//
//  Copyright © 2016 Yalantis. All rights reserved.
//

import UIKit

/// Makes a view rounded
/// - warning: The theme isn't performance optimized
/// - warning: Corner radius won't be updated if you change frame of the view
class RoundedViewTheme: NSObject {
    
    @IBOutlet var objects: [UIView] = [] {
        didSet {
            objects.forEach(apply)
        }
    }
    
    func apply(object: UIView) {
        object.layer.cornerRadius = object.bounds.width / 2
        object.layer.masksToBounds = true
    }
}
