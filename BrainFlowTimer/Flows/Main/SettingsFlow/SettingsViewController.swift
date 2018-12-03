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
    
    @IBOutlet private weak var workDurationTextField: UITextField!
    @IBOutlet private weak var breakDurationTextField: UITextField!
    @IBOutlet private weak var longBreakDurationTextField: UITextField!
    @IBOutlet private weak var dailyGoalTextField: UITextField!
    @IBOutlet private weak var sessionsUntilLongBreakTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeBindings()
    }
    
    private func initializeBindings() {        
        workDurationTextField.rx.text
            .bind(to: viewModel.workDurationChanged)
            .disposed(by: disposeBag)
    }
    
}
