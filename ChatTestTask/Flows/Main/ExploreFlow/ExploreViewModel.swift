//
//  TimerViewModel.swift
//
//  Copyright © 2016 Yalantis. All rights reserved.
//

import Foundation
import RxSwift

final class ExploreViewModel: HasDisposeBag {

    private let model: ExploreModel
    
    init(model: ExploreModel) {
        self.model = model
    }
    
}
