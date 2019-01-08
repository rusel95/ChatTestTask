//
//  TimerViewController.swift
//
//  Copyright © 2016 Yalantis. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class TimerViewController: UIViewController {
    
    var viewModel: TimerViewModel!
    
    @IBOutlet private var timeLabel: UILabel!
    @IBOutlet private weak var settingsButton: UIButton!
    @IBOutlet private weak var statisticButton: UIButton!
    @IBOutlet private weak var startButton: UIButton!
    @IBOutlet private weak var pauseButton: UIButton!
    @IBOutlet private weak var resetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeBindings()
    }
    
    private func initializeBindings() {
        viewModel.timerText
            .doOnNext { [weak self] (text) in
                self?.timeLabel.text = text
            }.disposed(by: disposeBag)
        
        settingsButton.rx.tap
            .bind(to: viewModel.settingsButtonTapped)
            .disposed(by: disposeBag)
        
        statisticButton.rx.tap
            .bind(to: viewModel.statisticButtonTapped)
            .disposed(by: disposeBag)
        
        startButton.rx.tap
            .bind(to: viewModel.startButtonTapped)
            .disposed(by: disposeBag)
        
        pauseButton.rx.tap
            .bind(to: viewModel.pauseButtonTapped)
            .disposed(by: disposeBag)
        
        resetButton.rx.tap
            .bind(to: viewModel.stopButtonTapped)
            .disposed(by: disposeBag)
    }
    
}
