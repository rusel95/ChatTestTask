//
//  DurationsCellModel.swift
//  Buyper
//
//  Created by Ruslan Popesku on 12/28/18.
//  Copyright © 2018 Yalantis. All rights reserved.
//

import RxSwift
import RxCocoa
import Core

final class DurationsModel: HasDisposeBag {
    
    // MARK: - Properties
    let workDurationChangedAction = PublishSubject<String?>()
    
    // MARK: - Init
    
    init() {
       
    }
    
}
