//
//  Timer.swift
//  Timer
//
//  Created by Andrew Porter on 2/9/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class Timer: NSObject {
    
    static let kSecondTick = "secondTick"
    static let kTimerComplete = "timerComplete"
    
    private(set) var seconds = NSTimeInterval(0)
    private(set) var totalSeconds = NSTimeInterval(0)
    private var timer: NSTimer?
    var isOn: Bool {
        get {
            if timer != nil {
                return true
            } else {
                return false
            }
        }
    }
    
    static let sharedInstance = Timer()
    
    func setTimer(seconds: NSTimeInterval, totalSeconds: NSTimeInterval) {
        self.seconds = seconds
        self.totalSeconds = totalSeconds
    }
    
    func startTimer() {
        if timer == nil {
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "secondTick", userInfo: nil, repeats: true)
        }
    }
    
    func stopTimer() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    
    func secondTick() {
        if timer != nil {
            totalSeconds -= 1
            NSNotificationCenter.defaultCenter().postNotificationName(Timer.kSecondTick, object: self, userInfo: nil)
            if totalSeconds <= 0 {
                NSNotificationCenter.defaultCenter().postNotificationName(Timer.kTimerComplete, object: self, userInfo: nil)
            }
        }
    }
    
    func timerString() -> String {
        let hourString: String
        let minuteString: String
        let secondString: String
        var totalSecondsRemainder = 0
        var hours = 0
        var minutes = 0
        var seconds = 0
        
        hours = Int(totalSeconds / 3600)
        totalSecondsRemainder = Int(totalSeconds % 3600)
        minutes = Int(totalSecondsRemainder / 60)
        totalSecondsRemainder = Int(totalSecondsRemainder % 60)
        seconds = Int(totalSecondsRemainder % 60)
        
        if hours < 10 {
            hourString = "0\(hours)"
        } else {
            hourString = "\(hours)"
        }
        if minutes < 10 {
            minuteString = "0\(minutes)"
        } else {
            minuteString = "\(minutes)"
        }
        if seconds < 10 {
            secondString = "0\(seconds)"
        } else {
            secondString = "\(seconds)"
        }
        
        return "\(hourString):\(minuteString):\(secondString)"
    }
}
























