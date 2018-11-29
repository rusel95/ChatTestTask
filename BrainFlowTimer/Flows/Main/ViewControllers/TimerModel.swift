//
//  MainMenuModel.swift
//
//  Copyright © 2016 Yalantis. All rights reserved.
//

import Foundation
import Core
import RxSwift
import RxCocoa

enum MainMenuEvent: Event {
    
}

final class TimerModel: EventNode, HasDisposeBag {
    
    var currentSecond = BehaviorRelay<Int>(value: 0)
    
    let startCountdownAction = PublishSubject<Void>()
    let pauseCountdownAction = PublishSubject<Void>()
    let stopCountdownAction = PublishSubject<Void>()
    
    private var timer = Timer()
    private var isTimerWorking = false
    
    override init(parent: EventNode) {
        super.init(parent: parent)
        
        currentSecond.accept(0)
        addHandlers()
        initializeBindings()
    }
    
    private func initializeBindings() {
        
        startCountdownAction
            .doOnNext { [unowned self] _ in
                self.scheduleTimer()
            }
            .disposed(by: disposeBag)
        
        pauseCountdownAction
            .doOnNext { [unowned self] _ in
                self.timer.invalidate()
                self.isTimerWorking = false
            }
            .disposed(by: disposeBag)
        
        stopCountdownAction
            .doOnNext { [unowned self] _ in
                KeyValueStorageService.removeObject(for: .savedTime)
                self.timer.invalidate()
                self.isTimerWorking = false
                self.currentSecond.accept(0)
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - private
    
    private func pauseWhenBackround() {
        timer.invalidate()
        isTimerWorking = false
        KeyValueStorageService.set(Date(), for: .savedTime)
    }
    
    private func willEnterForeground() {
        if let savedDate = KeyValueStorageService.object(for: .savedTime) as? Date {
            let components = Calendar.current.dateComponents([.second], from: savedDate, to: Date())
            self.currentSecond.accept(self.currentSecond.value + components.second!)
            scheduleTimer()
        }
    }
    
    private func scheduleTimer() {
        if !isTimerWorking {
            isTimerWorking = true
            let timeInterval = TimeInterval(1.0)
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [weak self] (_) in
                guard let self = self else { return }
                self.currentSecond.accept(self.currentSecond.value + Int(timeInterval))
            })
        }
    }
    private func addHandlers() {
        addHandler { [unowned self] (event: ApplicationEvent) in
            switch event {
            case .applicationDidEnterBackground:
                self.pauseWhenBackround()
            case .applicationWillEnterForeground:
                self.willEnterForeground()
            }
        }
    }
}
