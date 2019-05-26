//
//  TimerModel.swift
//
//  Copyright © 2016 Yalantis. All rights reserved.
//

import Foundation
import Core
import RxSwift
import RxCocoa
import RxRealm

final class ExploreModel: EventNode, HasDisposeBag {
    
    override init(parent: EventNode) {
        super.init(parent: parent)
        
        addHandlers()
        initializeBindings()
    }
    
    private func initializeBindings() {
        
    }
    
    // MARK: - private
    private func addHandlers() {
//        addHandler { [unowned self] (event: ApplicationEvent) in
//            switch event {
//            case .applicationDidEnterBackground:
//                self.pauseWhenBackround()
//            case .applicationWillEnterForeground:
//                self.willEnterForeground()
//            }
//        }
    }
}
