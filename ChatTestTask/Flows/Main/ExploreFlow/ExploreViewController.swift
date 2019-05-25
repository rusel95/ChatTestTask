//
//  TimerViewController.swift
//
//  Copyright © 2016 Yalantis. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class  ExploreViewController: UIViewController {
    
    var viewModel: ExploreViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeBindings()
    }
    
    private func initializeBindings() {

    }
    
}
