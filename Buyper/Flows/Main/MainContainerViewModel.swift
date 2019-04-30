//
//  MainContainerViewModel.swift
//  Buyper
//
//  Created by Ruslan Popesku on 4/26/19.
//  Copyright © 2019 Buyper. All rights reserved.
//

import RxSwift

final class MainContainerViewModel: HasDisposeBag {
    
    // MARK: - Properties.
    
    var switchToTabAction: PublishSubject<Tab> {
        return model.switchToTabAction
    }
    
    private let model: MainContainerModel
    
    // MARK: - Init.
    
    init(model: MainContainerModel) {
        self.model = model
    }
    
    func tabBarLoaded() {
        model.mainTabBarLoaded.onNext(())
    }
    
}
