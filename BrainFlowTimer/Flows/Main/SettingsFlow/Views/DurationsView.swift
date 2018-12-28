//
//  SettingsCell.swift
//  BrainFlowTimer
//
//  Created by Ruslan Popesku on 12/28/18.
//  Copyright © 2018 Yalantis. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class DurationsView: UIView, NibLoadable {
    
    @IBOutlet private weak var workDurationLabel: UILabel!
    @IBOutlet private weak var breakDurationLabel: UILabel!
    @IBOutlet private weak var longBreakDurationLabel: UILabel!
    @IBOutlet private weak var dailyGoalLabel: UILabel!
    @IBOutlet private weak var sessionsUntilLongBreakLabel: UILabel!
    @IBOutlet private weak var workDurationTextField: UITextField!
    @IBOutlet private weak var breakDurationTextField: UITextField!
    @IBOutlet private weak var longBreakDurationTextField: UITextField!
    @IBOutlet private weak var dailyGoalTextField: UITextField!
    @IBOutlet private weak var sessionsUntilLongBreakTextField: UITextField!
    
    // MARK: Properies
    
    var viewModel: DurationsViewModel! {
        didSet {
            initializeBindings()
        }
    }
    
    // MARK: Init
    
    // MARK: Private Methods
    
    private func initializeBindings() {
        
        workDurationLabel.text = viewModel.workDurationText
        breakDurationLabel.text = viewModel.breakDurationText
        longBreakDurationLabel.text = viewModel.longBreakDurationText
        dailyGoalLabel.text = viewModel.dailyGoalText
        sessionsUntilLongBreakLabel.text = viewModel.sessionsUntilLongBreakText
        //TODO: handle work duration change
//        workDurationTextField.rx.text
//            .bind(to: viewModel.workDurationChanged)
//            .disposed(by: disposeBag)
        
    }
    
}
