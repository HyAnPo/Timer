//
//  TimerViewController.swift
//  Timer
//
//  Created by Andrew Porter on 10/20/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var hourPickerView: UIPickerView!
    @IBOutlet weak var minutePickerView: UIPickerView!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    
    let timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let scheduledNotifications = UIApplication.sharedApplication().scheduledLocalNotifications else { return }
        timer.stopTimer()
        
        for notification in scheduledNotifications  {
            if notification.category == Timer.kTimerAlert {
                
                UIApplication.sharedApplication().cancelLocalNotification(notification)
                
                let now = NSDate()
                guard let fireDate = notification.fireDate, let userInfo = notification.userInfo as? [String : NSTimeInterval], let totalTime = userInfo[Timer.kTotalSeconds] else { return }
                let timeRemainingOnCountdown = fireDate.timeIntervalSinceDate(now)
                timer.setTime(timeRemainingOnCountdown, totalSeconds: totalTime)
                updateTimerBasedViews()
                timer.startTimer()
                switchToTimerView()
            }
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateTimerBasedViews", name: Timer.kTimerSecondTickNotification, object: timer)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "timerComplete", name: Timer.kTimerCompleteNotification, object: timer)
        
        minutePickerView.selectRow(1, inComponent: 0, animated: false)
        
        view.layoutIfNeeded()
        
        pauseButton.layer.cornerRadius = pauseButton.bounds.height / 2
        pauseButton.layer.masksToBounds = true
        pauseButton.layer.borderWidth = 2.0
        pauseButton.layer.borderColor = UIColor.blueColor().CGColor
        
        startButton.layer.cornerRadius = startButton.bounds.height / 2
        startButton.layer.masksToBounds = true
        startButton.layer.borderWidth = 2.0
        startButton.layer.borderColor = UIColor.purpleColor().CGColor

    }
    
    @IBAction func startButtonTapped(sender: UIButton) {
        // TODO: Spend time studing this
        let hasAskedPermissions = NSUserDefaults.standardUserDefaults().boolForKey(AppDelegate.kHasAskedPermissions)
        
        if !hasAskedPermissions {
            
            let prePermissionAlert = UIAlertController(title: "Notification Permissions", message: "We need your permission to notify you when your timer is done. You can change this permission any time in your settings.", preferredStyle: .Alert)
            prePermissionAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (_) in
                UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil))
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: AppDelegate.kHasAskedPermissions)
                self.toggleTimer()
                
            }))
            prePermissionAlert.addAction(UIAlertAction(title: "Maybe later", style: .Cancel, handler: { (_) in
                
                let alarmNotSetAlert = UIAlertController(title: "Timer Not Set", message: "Your timer is not set. Please enable notification permissions.", preferredStyle: .Alert)
                
                
                alarmNotSetAlert.addAction(UIAlertAction(title: "Don't set timer", style: .Cancel, handler: nil))
                alarmNotSetAlert.addAction(UIAlertAction(title: "Enable permission", style: .Default, handler: { (_) in
                    UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil))
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey: AppDelegate.kHasAskedPermissions)
                    self.toggleTimer()
                
                }))
                
                self.navigationController?.presentViewController(alarmNotSetAlert, animated: true, completion: nil)
            }))
            
            self.navigationController?.presentViewController(prePermissionAlert, animated: true, completion: nil)

        } else {
            self.toggleTimer()
        }
    }
    
    func toggleTimer() {
        if timer.isOn {
            //User wants to cancel timer
            timer.stopTimer()
            // TODO: switchToPickerView
            
        } else {
            // TODO: switchToTimerView
            
            let hours = hourPickerView.selectedRowInComponent(0)
            let minutes = minutePickerView.selectedRowInComponent(0) + (hours * 60)
            let totalSecondsSetOnTimer = NSTimeInterval(minutes * 60)
            
            timer.setTime(totalSecondsSetOnTimer, totalSeconds: totalSecondsSetOnTimer)
            // TODO: updateTimerBasedViews
            timer.startTimer()
        }
    }
    
    // TODO: Black Diamond
//    
//        @IBAction func pauseButtonTapped(sender: UIButton) {
//    }

    
    // MARK: UIPickerView Data Source
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == hourPickerView {
            return 25
        } else {
        return 60
        }
    }
    
    
    
    // MARK: UIPickerView Delegate
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row)"
    }

 
    // MARK: Update View Helper Methods
    func updateTimerLabel() {
        timerLabel.text = timer.timerString()
    }
    
    func updateProgressView() {
        let secondsElapsed = timer.totalSeconds - timer.seconds
        
        let progress = Float(secondsElapsed) / Float(timer.totalSeconds)
        
        progressView.setProgress(progress, animated: true)
    }
    
    func updateTimerBasedViews() {
        updateTimerLabel()
        updateProgressView()
    }
    
    func timerComplete() {
        // TODO: switchToPickerView()
    }
    
    func switchToTimerView() {
        timerLabel.hidden = false
        progressView.setProgress(0.0, animated: false)
        progressView.hidden = false
        // TODO: pickerStackView.hidden = true
        startButton.setTitle("Cancel", forState: .Normal)
        
        
        // TODO: Button UI layout
        startButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
        startButton.layer.borderColor = UIColor.blueColor().CGColor
        pauseButton.setTitleColor(UIColor.purpleColor(), forState: .Normal)
        pauseButton.layer.borderColor = UIColor.blueColor().CGColor
    }
    
    func switchToPickerView() {
        //TODO: pickerStackView.hidden = false
        timerLabel.hidden = true
        progressView.hidden = true
        startButton.setTitle("Start", forState: .Normal)
        
        
        // TODO: Button UI layout
        startButton.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        startButton.layer.borderColor = UIColor.orangeColor().CGColor
        pauseButton.setTitleColor(UIColor.redColor(), forState: .Normal)
        pauseButton.layer.borderColor = UIColor.redColor().CGColor
        
        
    }
    

}
