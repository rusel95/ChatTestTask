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

final class TimerModel: EventNode, HasDisposeBag {
    
    var durations: Durations?
    var currentSecond = BehaviorRelay<Int16>(value: 0)
    var currentTimeInterval: Int16 = 0 /// can be work and rest
    
    let settingsAction = PublishSubject<Void>()
    let startCountdownAction = PublishSubject<Void>()
    let pauseCountdownAction = PublishSubject<Void>()
    let stopCountdownAction = PublishSubject<Void>()
    
    private var timer = Timer()
    private var isTimerWorking = false
    
    override init(parent: EventNode) {
        super.init(parent: parent)
        
        addHandlers()
        subscribeOnSettingsChanges()
        initializeBindings()
    }
    
    private func initializeBindings() {
        
        settingsAction
            .doOnNext { [unowned self] _ in
                self.raise(event: MainFlowEvent.openSettings)
            }.disposed(by: disposeBag)
        
        startCountdownAction
            .doOnNext { [unowned self] _ in
                self.scheduleTimer()
            }.disposed(by: disposeBag)
        
        pauseCountdownAction
            .doOnNext { [unowned self] _ in
                self.timer.invalidate()
                self.isTimerWorking = false
            }.disposed(by: disposeBag)
        
        stopCountdownAction
            .doOnNext { [unowned self] _ in
                UserDataService.removeObject(for: .savedTime)
                self.timer.invalidate()
                self.isTimerWorking = false
                self.currentSecond.accept(self.currentTimeInterval)
            }.disposed(by: disposeBag)
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
            self.currentSecond.accept(self.currentSecond.value - Int16(components.second!))
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
        if let durations = RealmService.shared.realm.objects(Durations.self).first {
            Observable.propertyChanges(object: durations)
                .take(1)
                .doOnNext { [unowned self] changes in
                    if let newDurations = changes.newValue as? Durations {
                        self.durations = newDurations
                        self.currentSecond.accept(newDurations.workSession)
                    }
                }.disposed(by: disposeBag)
        }
    }
}
