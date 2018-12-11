//
//  SoundService.swift
//  BrainFlowTimer
//
//  Created by Ruslan Popesku on 12/7/18.
//  Copyright © 2018 Yalantis. All rights reserved.
//

import Foundation
import AudioToolbox
import AVFoundation

enum SoundType: String {
    
    case startCountdown1
    case startCountdown2
    case clockTick1
    case clockTick2
    case clockTick3
    case finish1
    
}

enum WhiteNoiceType: String {
    
    case silence
    case waves1
    
}

final class SoundService: NSObject {
    
    static let shared = SoundService()
    
    private var player = AVAudioPlayer()
    private override init() {
        super.init()
    }
    
    func playAlertSound(_ alertType: SoundType, withVibration: Bool = false) {
        if let filePath = Bundle.main.path(forResource: alertType.rawValue, ofType: "wav") {
            let soundURL = URL(fileURLWithPath: filePath)
            var soundID: SystemSoundID = 0
            if withVibration {
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
            AudioServicesCreateSystemSoundID(soundURL as CFURL, &soundID)
            AudioServicesPlaySystemSound(soundID)
        }
    }
    
    func playWhiteNoise(_ whiteNoiceType: WhiteNoiceType) {
        if let filePath = Bundle.main.path(forResource: whiteNoiceType.rawValue, ofType: "wav") {
            let whiteNoiceURL = URL(fileURLWithPath: filePath)
            do {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback,
                                                                with: AVAudioSessionCategoryOptions.mixWithOthers)
                try AVAudioSession.sharedInstance().setActive(true)
                try self.player = AVAudioPlayer(contentsOf: whiteNoiceURL)
                self.player.numberOfLoops = -1
                self.player.volume = 1
                self.player.prepareToPlay()
                self.player.play()
            } catch {
                debugPrint(error)
            }
        }
    }
    
}
