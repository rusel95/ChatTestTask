//
//  SettingsViewModel.swift
//  BrainFlowTimer
//
//  Created by Ruslan Popesku on 11/29/18.
//  Copyright © 2018 Yalantis. All rights reserved.
//

import Foundation
import RxSwift

final class StatisticViewModel: HasDisposeBag {
    
    private let model: StatisticModel
    
    init(model: StatisticModel) {
        self.model = model
        initializeBindings()
    }
    
    private func initializeBindings() {
        
    }
    
}
