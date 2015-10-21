//
//  Timer.swift
//  Timer
//
//  Created by Andrew Porter on 10/20/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

class Timer: NSObject {
    
    static let kTimerSecondTickNotification = "kTimerSecondTickNotification"
    static let kTimerCompleteNotification = "kTimerCompleteNotification"
    
    private(set) var seconds = NSTimeInterval(0)
    private(set) var totalSeconds = NSTimeInterval(0)
    private var timer: NSTimer?
    var isOn: Bool {
        get {
            if timer == nil {
                return false
            } else {
                return true
            }
        }
    }


    func setTime(seconds: NSTimeInterval, totalSeconds: NSTimeInterval) {
        self.seconds = seconds
        self.totalSeconds = totalSeconds
    }

    func startTimer() {
        if (timer == nil) {
            timer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(1.0), target: self, selector: "secondTick", userInfo: nil, repeats: true)
        }
        
    }

    func stopTimer() {
        if timer != nil {
            timer?.invalidate()
            self.timer = nil
        }
    }

    func secondTick() {
        if timer != nil {
        seconds--;
        
NSNotificationCenter.defaultCenter().postNotificationName(Timer.kTimerSecondTickNotification, object: self)
        
        if seconds <= 0 {
        NSNotificationCenter.defaultCenter().postNotificationName(Timer.kTimerCompleteNotification, object: self)
            stopTimer()
        }
    }
}

    func timerString() -> String {
        
        let totalseconds = Int(self.seconds)
        
        let hours = totalseconds / 3600
        let minutes = (totalseconds - (hours * 3600)) / 60
        let seconds = (totalseconds - (hours * 3600) - (minutes * 60))
        
        var hoursString = ""
        if hours > 0 {
            hoursString = "\(hours)"
        }
        
        var minutesString = ""
        if minutes > 0 {
            minutesString = "\(minutes)"
        }
        
        var secondsString = ""
        if seconds > 0 {
            secondsString = "\(seconds)"
        }
        
        return "\(hoursString):\(minutesString):\(secondsString)"
    }

}






























