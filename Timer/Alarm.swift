//
//  Alarm.swift
//  Timer
//
//  Created by Andrew Porter on 10/21/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit
import Foundation

class Alarm: NSObject {
    static let kAlarmAlert = "alarmAlert"
    static let kAlarmCompleteNotification = "kAlarmCompleteNotification"
    
    private(set) var alarmDate: NSDate?
    var isArmed: Bool? {
        get {
            if alarmDate != nil {
                return true
            } else {
                return false
            }
        }
    }
    
    // TODO: Don't fully grasp what private does
    private var localNotification: UILocalNotification?
    
    func arm(fireDate: NSDate) {
        // TODO: get confused what to set what
        alarmDate = fireDate
        let alarmNotification = UILocalNotification()
        alarmNotification.fireDate = alarmDate
        alarmNotification.timeZone = NSTimeZone.localTimeZone()
        alarmNotification.soundName = "sms-received3.caf"
        alarmNotification.alertBody = "Alarm Complete!"
        alarmNotification.category = Alarm.kAlarmAlert
        
        UIApplication.sharedApplication().scheduleLocalNotification(alarmNotification)
    }
    
    func cancel() {
        
        if (isArmed != nil) {
            alarmDate = nil
            if let localNotification = localNotification {
                UIApplication.sharedApplication().cancelLocalNotification(localNotification)
            }
        }
    }
    
    func alarmComplete() {
        NSNotificationCenter.defaultCenter().postNotificationName(Alarm.kAlarmCompleteNotification, object: nil)
    }
}
