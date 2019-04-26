//
//  SettingsModel.swift
//  Buyper
//
//  Created by Ruslan Popesku on 11/29/18.
//  Copyright © 2018 Yalantis. All rights reserved.
//

import Foundation
import Core
import RxSwift
import RxCocoa

final class SettingsModel: EventNode, HasDisposeBag {
    
    let durationsModel = DurationsModel()
    
    override init(parent: EventNode) {
        super.init(parent: parent)
        
        initializeBindings()
    }
    
    private func initializeBindings() {
        durationsModel.workDurationChangedAction
            .doOnNext { newWorkDurationText in
                if let durations = RealmService.shared.realm.objects(Durations.self).first,
                    let newWorkDurationText = newWorkDurationText,
                    let workDuration = Int16(newWorkDurationText) {
                    try? RealmService.shared.realm.write {
                        durations.work = workDuration
                        RealmService.shared.realm.add(durations, update: true)
                    }
                }
            }.disposed(by: disposeBag)
    }
    
    // MARK: - private
    
}
