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
    
    var durations: Durations? {
        didSet {
            self.currentSecond.accept(durations?.work ?? 0)
        }
    }
    var currentSecond = BehaviorRelay<Int16>(value: 0)
    
    let settingsAction = PublishSubject<Void>()
    let statisticAction = PublishSubject<Void>()
    let startCountdownAction = PublishSubject<Void>()
    let pauseCountdownAction = PublishSubject<Void>()
    let stopCountdownAction = PublishSubject<Void>()
    
    private var timer = Timer()
    private var isTimerWorking = false
    
    override init(parent: EventNode) {
        super.init(parent: parent)
        
        addHandlers()
        initializeBindings()
    }
    
    private func initializeBindings() {

        pauseCountdownAction
            .doOnNext { [unowned self] _ in
                self.timer.invalidate()
                self.isTimerWorking = false
            }.disposed(by: disposeBag)
        
        stopCountdownAction
            .doOnNext { [unowned self] _ in
                guard let durations = self.durations else { return }
                UserDataService.removeObject(for: .savedTime)
                self.timer.invalidate()
                self.isTimerWorking = false
                self.currentSecond.accept(durations.work)
            }.disposed(by: disposeBag)
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
