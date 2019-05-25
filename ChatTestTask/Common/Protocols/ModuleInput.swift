//
//  ModuleInput.swift
//
//  Copyright © 2016 Yalantis. All rights reserved.
//

import UIKit

protocol ModuleInput {
    
    var initialViewController: UIViewController { get }
    var containerViewController: UIViewController? { get set }
    
}

extension ModuleInput {
    
    var containerViewController: UIViewController? {
        get {
            return nil
        }
        set {
            fatalError("Module \(self) doesn't support container")
        }
    }
    
    var navigationController: UINavigationController? {
        return containerViewController as? UINavigationController
    }
    
}
