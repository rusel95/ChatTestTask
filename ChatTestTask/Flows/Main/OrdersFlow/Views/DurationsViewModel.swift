//
//  SettingDurationsCellViewModel.swift
//  ChatTestTask
//
//  Created by Ruslan Popesku on 12/28/18.
//  Copyright © 2018 Yalantis. All rights reserved.
//

import UIKit
import RxSwift

final class DurationsViewModel: HasDisposeBag {
    
    // MARK: Properies.
    var workDurationChanged: PublishSubject<String?> {
        return model.workDurationChangedAction
    }
    
    var workDurationText: String {
        return L10n.settingsWorkDuration
    }
    
    var breakDurationText: String {
        return L10n.settingsBreakDuration
    }
    
    var longBreakDurationText: String {
        return L10n.settingsLongBreak
    }
    
    var dailyGoalText: String {
        return L10n.settingsDailyGoal
    }
    
    var sessionsUntilLongBreakText: String {
        return L10n.settingsSessionsUntilLongBreak
    }
    
    private let model: DurationsModel
    
    // MARK: Init.
    
    init(model: DurationsModel) {
        self.model = model
    }
    
}
