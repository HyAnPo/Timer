//
//  Timer.swift
//  Timer
//
//  Created by Andrew Porter on 10/19/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

class Timer: NSObject {
    
    static let TimerSecondTickNotification = "TimerSecondTickNotification"
    static let TimerCompleteNotification = "TimerCompleteNotification"
    
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
            NSNotificationCenter.defaultCenter().postNotificationName(<#T##aName: String##String#>, object: <#T##AnyObject?#>, userInfo: <#T##[NSObject : AnyObject]?#>)
        }
        
    }

    func timerString() -> String {
        
        return ""
    }
    
}
