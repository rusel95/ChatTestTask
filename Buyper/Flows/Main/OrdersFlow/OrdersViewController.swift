//
//  SettingsViewController.swift
//  Buyper
//
//  Created by Ruslan Popesku on 11/29/18.
//  Copyright © 2018 Yalantis. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class OrdersViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: OrdersViewModel!
     
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeBindings()
    }
    
    // MARK: - Private Methods
    private func initializeBindings() {
        
    }
    
}
