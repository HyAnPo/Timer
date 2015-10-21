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
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateTimerBasedViews", name: Timer.kTimerSecondTickNotification, object: timer)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "timerComplete", name: Timer.kTimerCompleteNotification, object: timer)
        
        minutePickerView.selectRow(1, inComponent: 0, animated: false)
        
        view.layoutIfNeeded()

    }
    
    @IBAction func startButtonTapped(sender: UIButton) {
        
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
        @IBAction func pauseButtonTapped(sender: UIButton) {
    }

    
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

 
    
    

}
