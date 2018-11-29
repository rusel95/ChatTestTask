//
//  SettingsModel.swift
//  BrainFlowTimer
//
//  Created by Ruslan Popesku on 11/29/18.
//  Copyright © 2018 Yalantis. All rights reserved.
//

import Foundation
import Core
import RxSwift
import RxCocoa

final class SettingsModel: EventNode, HasDisposeBag {
    
    let countDownDateAction = PublishSubject<Date>()
    
    override init(parent: EventNode) {
        super.init(parent: parent)
        
        initializeBindings()
    }
    
    private func initializeBindings() {
        
        countDownDateAction
            .doOnNext { date in
                let components = Calendar.current.dateComponents([.hour, .minute], from: date)
                let chosenTimeInterval = components.hour! * 3600 + components.minute! * 60
                UserDataService.set(chosenTimeInterval, for: .chosenTimeInterval)
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - private
    
}
