//
//  MainMenuViewController.swift
//
//  Copyright © 2016 Yalantis. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class TimerViewController: UIViewController {
    
    var viewModel: TimerViewModel!
    
    @IBOutlet private var timeLabel: UILabel!
    @IBOutlet private weak var startButton: UIButton!
    @IBOutlet private weak var endButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeBindings()
    }
    
    private func initializeBindings() {
        viewModel.timerText
            .doOnNext { [weak self] (text) in
                self?.timeLabel.text = text
            }.disposed(by: disposeBag)
        
        startButton.rx.tap
            .bind(to: viewModel.startButtonTapped)
            .disposed(by: disposeBag)
        
        endButton.rx.tap
            .bind(to: viewModel.startButtonTapped)
            .disposed(by: disposeBag)
    }
    
}
