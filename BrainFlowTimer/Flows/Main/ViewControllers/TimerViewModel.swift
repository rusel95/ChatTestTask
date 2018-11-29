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
    
    var stopButtonTapped: PublishSubject<Void> {
        return model.stopCountdownAction
    }
    
    let timerText = PublishSubject<String>()
    
    private let model: TimerModel
    
    init(model: TimerModel) {
        self.model = model
        initializeBindings()
    }
    
    private func initializeBindings() {
        model.currentSecond
            .doOnNext { (currentSecond) in
                let numberOfSecondsInHour = 3600
                let hours = Int(currentSecond / numberOfSecondsInHour)
                let numberOfSecondsInMinute = 60
                let minutes = Int(currentSecond / numberOfSecondsInMinute)
                let secondsToShow = currentSecond % numberOfSecondsInMinute
                self.timerText.onNext(
                    String(
                        format: "%02d : %02d : %02d",
                        hours, minutes, secondsToShow)
                    )
            }.disposed(by: disposeBag)
    }
    
}
