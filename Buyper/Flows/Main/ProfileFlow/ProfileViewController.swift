//
//  ProfileViewController.swift
//  Buyper
//
//  Created by Ruslan Popesku on 4/29/19.
//  Copyright © 2019 Buyper. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: ProfileViewModel!

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeBindings()
    }
    
    // MARK: - Private Methods
    private func initializeBindings() {
        
    }
    
}
