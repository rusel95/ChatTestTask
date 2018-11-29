//
//  MainMenuViewModel.swift
//
//  Copyright © 2016 Yalantis. All rights reserved.
//

import Foundation
import RxSwift

final class TimerViewModel: HasDisposeBag {
    
    var startButtonTapped: PublishSubject<Void> {
        return model.startCountdownAction
    }
    
    var pauseButtonTapped: PublishSubject<Void> {
        return model.pauseCountdownAction
    }
    
    var resetButtonTapped: PublishSubject<Void> {
        return model.resetCountdownAction
    }
    
    let timerText = PublishSubject<String>()
    
    private let model: TimerModel
    
    init(model: TimerModel) {
        self.model = model
        initializeBindings()
    }
    
    private func initializeBindings() {
        model.updateTimer
            .doOnNext({ [unowned self] _ in
                
                self.timerText.onNext(
                    String(
                        format: "%02d : %02d : %02d",
                        self.model.hrs, self.model.min, self.model.sec)
                )
            })
            .disposed(by: disposeBag)
    }
    
}
