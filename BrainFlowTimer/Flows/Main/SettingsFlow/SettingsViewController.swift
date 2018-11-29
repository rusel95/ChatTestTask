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

final class SettingsViewController: UIViewController {
    
    var viewModel: SettingsViewModel!
    
    @IBOutlet private weak var datePickerView: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeBindings()
    }
    
    private func initializeBindings() {        
        datePickerView.rx.date
            .bind(to: viewModel.countdownTimePicked)
            .disposed(by: disposeBag)
    }
    
}
