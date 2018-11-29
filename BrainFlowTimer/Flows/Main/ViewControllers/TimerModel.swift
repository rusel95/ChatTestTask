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
    var diffHrs = 0
    var diffMins = 0
    var diffSecs = 0
    
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
                self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [weak self] (_) in
                    self?.timerTick()
                })
            }
            .disposed(by: disposeBag)
        
        pauseCountdownAction
            .doOnNext { [unowned self] _ in
                debugPrint("pause")
            }
            .disposed(by: disposeBag)
        
        resetCountdownAction
            .doOnNext { [unowned self] _ in
                self.resetContent()
                debugPrint("reset")
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - private
    
    private func pauseWhenBackround() {
        self.timer.invalidate()
        let shared = UserDefaults.standard
        shared.set(Date(), forKey: "savedTime")
        print(Date())
    }
    
    private func willEnterForeground() {
        if let savedDate = UserDefaults.standard.object(forKey: "savedTime") as? Date {
            setTimeDifference(startDate: savedDate)
            
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
    
    private func setTimeDifference(startDate: Date) {
        let components = Calendar.current.dateComponents([.hour, .minute, .second], from: startDate, to: Date())
        diffHrs = components.hour!
        diffMins = components.minute!
        diffSecs = components.second!
    }
    
    private func addBackgroundTime(hours: Int, minutes: Int, seconds: Int) {
        self.hrs += hours
        self.min += minutes
        self.sec += seconds
        
    }
    
    func removeSavedDate() {
        if (UserDefaults.standard.object(forKey: "savedTime") as? Date ) != nil {
            UserDefaults.standard.removeObject(forKey: "savedTime")
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
