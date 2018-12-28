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
import fluid_slider

final class DurationsView: UIView, NibLoadable {
    
    @IBOutlet private weak var workDurationLabel: UILabel!
    @IBOutlet private weak var breakDurationLabel: UILabel!
    @IBOutlet private weak var longBreakDurationLabel: UILabel!
    @IBOutlet private weak var dailyGoalLabel: UILabel!
    @IBOutlet private weak var sessionsUntilLongBreakLabel: UILabel!
    @IBOutlet private weak var workDurationSlider: Slider!
    @IBOutlet private weak var breakDurationSlider: Slider!
    @IBOutlet private weak var longBreakDurationSlider: Slider!
    @IBOutlet private weak var dailyGoalSlider: Slider!
    @IBOutlet private weak var sessionsUntilLongBreakSlider: Slider!
    
    // MARK: Properies
    
    var viewModel: DurationsViewModel! {
        didSet {
            initializeBindings()
        }
    }
    
    // MARK: Init
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        configureSliders()
    }
    
    // MARK: Private Methods
    
    private func initializeBindings() {
        
        workDurationLabel.text = viewModel.workDurationText
        breakDurationLabel.text = viewModel.breakDurationText
        longBreakDurationLabel.text = viewModel.longBreakDurationText
        dailyGoalLabel.text = viewModel.dailyGoalText
        sessionsUntilLongBreakLabel.text = viewModel.sessionsUntilLongBreakText
       
    }
    
    private func configureSliders() {
        configure(slider: workDurationSlider, minValue: 1, maxValue: 90)
        configure(slider: breakDurationSlider, minValue: 1, maxValue: 90)
        configure(slider: longBreakDurationSlider, minValue: 10, maxValue: 90)
        configure(slider: dailyGoalSlider, minValue: 2, maxValue: 24)
        configure(slider: sessionsUntilLongBreakSlider, minValue: 2, maxValue: 12)
    }
    
    private func configure(slider: Slider,
                           minValue: UInt,
                           maxValue: UInt,
                           contentColor: UIColor = UIColor(red: 78/255.0, green: 77/255.0, blue: 224/255.0, alpha: 1)) {
        slider.attributedTextForFraction = { fraction in
            let formatter = NumberFormatter()
            formatter.maximumIntegerDigits = 2
            formatter.maximumFractionDigits = 0
            let string = formatter.string(from: (fraction * 90) as NSNumber) ?? ""
            return NSAttributedString(string: string)
        }
        
        slider.setMinimumLabelAttributedText(NSAttributedString(string: "1"))
        slider.setMaximumLabelAttributedText(NSAttributedString(string: "90"))
        slider.fraction = 0.5
        slider.shadowOffset = CGSize(width: 0, height: 10)
        slider.shadowBlur = 5
        slider.shadowColor = UIColor(white: 0, alpha: 0.1)
        slider.contentViewColor = contentColor
        slider.valueViewColor = .white
    }
    
}
