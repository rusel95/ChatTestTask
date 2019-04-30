//
//  SettingsViewModel.swift
//  Buyper
//
//  Created by Ruslan Popesku on 11/29/18.
//  Copyright © 2018 Yalantis. All rights reserved.
//

import Foundation
import RxSwift

final class OrdersViewModel: HasDisposeBag {
    
    private let model: OrdrersModel
    
    init(model: OrdrersModel) {
        self.model = model
        initializeBindings()
    }
    
    private func initializeBindings() {
        
    }
    
}
