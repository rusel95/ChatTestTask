//
//  MainMenuModel.swift
//
//  Copyright © 2016 Yalantis. All rights reserved.
//

import Foundation
import Core
import RxSwift

enum MainMenuEvent: Event {
    
}

final class TimerModel: EventNode, HasDisposeBag {
    
    var timer = Timer()
    var hrs = 0
    var min = 0
    var sec = 0
    
    let updateTimer = PublishSubject<Void>()
    
    let startCountdownAction = PublishSubject<Void>()
    let pauseCountdownAction = PublishSubject<Void>()
    let resetCountdownAction = PublishSubject<Void>()
    
    override init(parent: EventNode) {
        super.init(parent: parent)
        
        addHandlers()
        initializeBindings()
    }
    
    private func initializeBindings() {
        
        startCountdownAction
            .doOnNext { [unowned self] _ in
                debugPrint("start")
                self.scheduleTimer()
            }
            .disposed(by: disposeBag)
        
        pauseCountdownAction
            .doOnNext { [unowned self] _ in
                debugPrint("pause")
                self.timer.invalidate()
            }
            .disposed(by: disposeBag)
        
        resetCountdownAction
            .doOnNext { [unowned self] _ in
                KeyValueStorageService.removeObject(for: .savedTime)
                self.resetContent()
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - private
    
    private func pauseWhenBackround() {
        self.timer.invalidate()
        KeyValueStorageService.set(Date(), for: .savedTime)
    }
    
    private func willEnterForeground() {
        if let savedDate = KeyValueStorageService.object(for: .savedTime) as? Date {
            let components = Calendar.current.dateComponents([.hour, .minute, .second], from: savedDate, to: Date())
            self.hrs += components.hour!
            self.min += components.minute!
            self.sec += components.second!
            updateTimer.onNext(())
            scheduleTimer()
        }
    }
    
    private func timerTick() {
        if self.sec == 59 {
            self.min += 1
            self.sec = 0
            if (self.min == 59) {
                self.hrs += 1
                self.min = 0
            }
        } else {
            self.sec += 1
        }
        updateTimer.onNext(())
    }
    
    private func resetContent() {
        timer.invalidate()
        self.sec = 0
        self.min = 0
        self.hrs = 0
    }
    
    private func scheduleTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [weak self] (_) in
            self?.timerTick()
        })
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
