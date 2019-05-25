//
//  SettingsCell.swift
//  ChatTestTask
//
//  Created by Ruslan Popesku on 12/28/18.
//  Copyright © 2018 Yalantis. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class DurationsView: UIView, NibLoadable {
    
    @IBOutlet private weak var workDurationLabel: UILabel!
    @IBOutlet private weak var breakDurationLabel: UILabel!
    @IBOutlet private weak var longBreakDurationLabel: UILabel!
    @IBOutlet private weak var dailyGoalLabel: UILabel!
    @IBOutlet private weak var sessionsUntilLongBreakLabel: UILabel!
    
    // MARK: Properies
    
    var viewModel: DurationsViewModel! {
        didSet {
            initializeBindings()
        }
    }
    
    // MARK: Init
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
    }
    
    // MARK: Private Methods
    
    private func initializeBindings() {
        
        workDurationLabel.text = viewModel.workDurationText
        breakDurationLabel.text = viewModel.breakDurationText
        longBreakDurationLabel.text = viewModel.longBreakDurationText
        dailyGoalLabel.text = viewModel.dailyGoalText
        sessionsUntilLongBreakLabel.text = viewModel.sessionsUntilLongBreakText
       
    }
    
    private func configure() {
        
    }
    
}
