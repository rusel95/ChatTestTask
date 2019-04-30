//
//  ProfileViewModel.swift
//  Buyper
//
//  Created by Ruslan Popesku on 4/29/19.
//  Copyright © 2019 Buyper. All rights reserved.
//

import Foundation
import RxSwift

final class ProfileViewModel: HasDisposeBag {
    
    private let model: ProfileModel
    
    init(model: ProfileModel) {
        self.model = model
        initializeBindings()
    }
    
    private func initializeBindings() {
        
    }
    
}
