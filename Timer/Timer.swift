//
//  Timer.swift
//  Timer
//
//  Created by Andrew Porter on 10/19/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

class Timer: NSObject {
    
    let TimerSecondTickNotification = "TimerSecondTickNotification"
    let TimerCompleteNotification = "TimerCompleteNotification"
    
    private(set) var seconds = NSTimeInterval(0)
    private(set) var totalSeconds = NSTimeInterval(0)
    private var timer: NSTimer?
    var isOn: Bool
    
    init(timer: NSTimer, isOn: Bool) {
        self.timer = timer
        self.isOn = Bool {
            get {
                if timer == nil {
                    return false
                } else {
                    return true
                }
            }
        }
    }
    
    func setTime(seconds: NSTimeInterval, totalSeconds: NSTimeInterval) {
        self.seconds = seconds
        self.totalSeconds = totalSeconds
        
    }
    
    
    func startTimer() {
        if (timer == nil) {
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "secondTick", userInfo: nil, repeats: true)
        
    }
    
    func stopTimer() {
        if let timer = timer {
            timer.invalidate()
            self.timer = nil
        }
    }
    
    func secondTick() {
        if timer != nil {
            seconds--
            NSNotificationCenter.defaultCenter().postNotificationName(TimerSecondTickNotification, object: self)
            if timer == 0 {
                NSNotificationCenter.defaultCenter().postNotificationName(TimerCompleteNotification, object: self)
                stopTimer()
            }
        }
        
    }

    func timerString() -> String {
        
        let totalSeconds = Int(self.seconds)
        
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds - (hours * 3600)) / 60
        let seconds = totalSeconds - (hours * 3600) - (minutes * 60)
        
        return ""
    }
    
}
