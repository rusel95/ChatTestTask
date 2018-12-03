//
//  SettingsViewModel.swift
//  BrainFlowTimer
//
//  Created by Ruslan Popesku on 11/29/18.
//  Copyright © 2018 Yalantis. All rights reserved.
//

import Foundation
import RxSwift

final class SettingsViewModel: HasDisposeBag {
    
    var workDurationChanged: PublishSubject<String?> {
        return model.workDurationChangedAction
    }
    
    private let model: SettingsModel
    
    init(model: SettingsModel) {
        self.model = model
        initializeBindings()
    }
    
    private func initializeBindings() {
        
    }
    
}
