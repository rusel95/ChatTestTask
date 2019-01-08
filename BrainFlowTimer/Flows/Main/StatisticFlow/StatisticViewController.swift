//
//  SettingsViewController.swift
//  BrainFlowTimer
//
//  Created by Ruslan Popesku on 11/29/18.
//  Copyright © 2018 Yalantis. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class StatisticViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet private weak var container: UIView!
    
    var viewModel: StatisticViewModel!
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeBindings()
    }
    
    // MARK: - Private Methods
    private func initializeBindings() {
        
    }

}
