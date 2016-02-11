//
//  TimerViewController.swift
//  Timer
//
//  Created by Andrew Porter on 2/9/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    //MARK: - Outlets
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var hoursPickerView: UIPickerView!
    @IBOutlet weak var minutesPickerView: UIPickerView!
    @IBOutlet weak var pickerViewStackView: UIStackView!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    //MARK: - Variables
    var timerState = TimerState.TimerOff
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - PickerView Data Source methods
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    
        if pickerView === hoursPickerView {
            return 24
        } else if pickerView === minutesPickerView {
            return 60
        } else {
            return 0
        }
    }
    
    //MARK: - PickerView Delegate methods
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row)
    }
    
    //MARK: - Actions
    @IBAction func startButtonTapped(sender: UIButton) {
        
        let totalSeconds: Double = Double((hoursPickerView.selectedRowInComponent(0) * 3600) + (minutesPickerView.selectedRowInComponent(0) * 60))
        print(totalSeconds)
        
        if timerState == .TimerOff {
            updateView()
            Timer.sharedInstance.setTimer(totalSeconds, totalSeconds: totalSeconds)
            updateTimeLabel()
            Timer.sharedInstance.startTimer()
            listenForSecondTick()
            
            timerState = .TimerOn
        } else if timerState == .TimerOn {
            updateView()
            Timer.sharedInstance.stopTimer()
            timerState = .TimerOff
        }
        
        
    }
    @IBAction func pauseButtonTapped(sender: UIButton) {
        
        Timer.sharedInstance.stopTimer()
    }
    
    //MARK: - Functions
    
    func updateView() {
        switch timerState {
            
        case .TimerOff:
            timeLabel.hidden = false
            pickerViewStackView.hidden = true
            progressBar.hidden = false
            startButton.setTitle("Cancel", forState: .Normal)
            
        case .TimerOn:
            timeLabel.hidden = true
            pickerViewStackView.hidden = false
            progressBar.hidden = true
            startButton.setTitle("Start", forState: .Normal)
            
        }
    }
    
    func updateTimeLabel() {
        timeLabel.text = Timer.sharedInstance.timerString()
    }
    
    func listenForSecondTick() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateTimeLabel", name: Timer.kSecondTick, object: nil)
    }
}






























