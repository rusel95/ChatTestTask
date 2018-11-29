//
//  TimerModel.swift
//
//  Copyright © 2016 Yalantis. All rights reserved.
//

import Foundation
import Core
import RxSwift
import RxCocoa

final class TimerModel: EventNode, HasDisposeBag {
    
    var chosenTimeInterval: Int
    var currentSecond = BehaviorRelay<Int>(value: 0)
    
    let startCountdownAction = PublishSubject<Void>()
    let pauseCountdownAction = PublishSubject<Void>()
    let stopCountdownAction = PublishSubject<Void>()
    
    private var timer = Timer()
    private var isTimerWorking = false
    
    override init(parent: EventNode) {
        chosenTimeInterval = UserDataService
            .object(for: .chosenTimeInterval) as? Int ?? Constants.defaultCountdownInterval
        currentSecond.accept(chosenTimeInterval)
        
        super.init(parent: parent)
        
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
                UserDataService.removeObject(for: .savedTime)
                self.timer.invalidate()
                self.isTimerWorking = false
                self.currentSecond.accept(self.chosenTimeInterval)
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - private
    
    private func pauseWhenBackround() {
        timer.invalidate()
        isTimerWorking = false
        UserDataService.set(Date(), for: .savedTime)
    }
    
    private func willEnterForeground() {
        if let savedDate = UserDataService.object(for: .savedTime) as? Date {
            let components = Calendar.current.dateComponents([.second], from: savedDate, to: Date())
            self.currentSecond.accept(self.currentSecond.value + components.second!)
            scheduleTimer()
        }
    }
    
    private func scheduleTimer() {
        if !isTimerWorking {
            isTimerWorking = true
            timer = Timer.scheduledTimer(
                withTimeInterval: TimeInterval(Constants.defaultTickTimeInterval),
                repeats: true,
                block: { [weak self] (_) in
                    guard let self = self else { return }
                    self.currentSecond.accept(self.currentSecond.value - Constants.defaultTickTimeInterval)
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
    
    private func subscribeOnSettingsChanges() {
        UserDataService.observe(Int.self, .chosenTimeInterval)
            .doOnNext { [weak self] (newTimeInterval) in
                if let self = self, let newTimeInterval = newTimeInterval {
                    self.chosenTimeInterval = newTimeInterval
                }
            }.disposed(by: disposeBag)
    }
}
