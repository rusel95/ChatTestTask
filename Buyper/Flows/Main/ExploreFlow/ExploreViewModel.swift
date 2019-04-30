//
//  TimerViewModel.swift
//
//  Copyright © 2016 Yalantis. All rights reserved.
//

import Foundation
import RxSwift

final class ExploreViewModel: HasDisposeBag {
    
    var settingsButtonTapped: PublishSubject<Void> {
        return model.settingsAction
    }
    
    var statisticButtonTapped: PublishSubject<Void> {
        return model.statisticAction
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
                let hours = currentSecond / Constants.numberOfSecondsInHour
                let minutes = (currentSecond - (Constants.numberOfSecondsInHour * hours)) /
                    Constants.numberOfSecondsInMinute
                let secondsToShow = currentSecond % Constants.numberOfSecondsInMinute
                return String(format: "%02d : %02d : %02d", hours, minutes, secondsToShow)
            })
        
    }
    private let model: ExploreModel
    
    init(model: ExploreModel) {
        self.model = model
    }
    
}
