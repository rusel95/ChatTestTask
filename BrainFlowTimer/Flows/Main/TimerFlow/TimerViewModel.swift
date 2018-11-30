//
//  TimerViewModel.swift
//
//  Copyright © 2016 Yalantis. All rights reserved.
//

import Foundation
import RxSwift

final class TimerViewModel: HasDisposeBag {
    
    var settingsButtonTapped: PublishSubject<Void> {
        return model.settingsAction
    }
    
    var startButtonTapped: PublishSubject<Void> {
        return model.startCountdownAction
    }
    
    var pauseButtonTapped: PublishSubject<Void> {
        return model.pauseCountdownAction
    }
    
    var stopButtonTapped: PublishSubject<Void> {
        return model.stopCountdownAction
    }
    
    var timerText: Observable<String> {
        return model.currentSecond
            .map({ (currentSecond) -> String in
                let hours = Int(currentSecond / Constants.numberOfSecondsInHour)
                let minutes = Int((currentSecond - (Constants.numberOfSecondsInHour * hours)) /
                    Constants.numberOfSecondsInMinute)
                let secondsToShow = currentSecond % Constants.numberOfSecondsInMinute
                return String(format: "%02d : %02d : %02d", hours, minutes, secondsToShow)
            })
        
    }
    private let model: TimerModel
    
    init(model: TimerModel) {
        self.model = model
    }
    
}
