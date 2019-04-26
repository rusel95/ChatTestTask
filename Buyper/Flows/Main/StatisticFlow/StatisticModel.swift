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

final class StatisticModel: EventNode, HasDisposeBag {
    
    override init(parent: EventNode) {
        super.init(parent: parent)
        
        initializeBindings()
    }
    
    private func initializeBindings() {
       
    }
    
    // MARK: - private
    
}
