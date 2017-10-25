//
//  ViewController.swift
//  Timer
//
//  Created by tomotaka.kato on 2017/10/25.
//  Copyright © 2017 tomotaka.kato. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var timer: Timer?
    var duration = 0
    let settingKey = "timerValue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let settings = UserDefaults.standard
        settings.register(defaults: [settingKey: 60])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        duration = 0
        _ = displayUpdate()
    }


    @IBOutlet weak var timeDisplay: UILabel!
    @IBAction func settingButtonAction(_ sender: Any) {
        if let nowTimer = timer {
            if nowTimer.isValid == true {
                nowTimer.invalidate()
            }
        }
        performSegue(withIdentifier: "openSetting", sender: nil)
    }
    @IBAction func startTimerAction(_ sender: Any) {
        if let nowTimer = timer {
            if nowTimer.isValid == true {
                return
            }
        }
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timerStop(_:)), userInfo: nil, repeats: true)
    }
    @IBAction func stopTimerAction(_ sender: Any) {
        if let nowTimer = timer {
            if nowTimer.isValid == true {
                nowTimer.invalidate()
            }
        }
    }
    
    func displayUpdate() -> Int {
        let settings = UserDefaults.standard
        let timerValue = settings.integer(forKey: settingKey)
        let remainSeconds = timerValue - duration
        timeDisplay.text = "あと\(remainSeconds)秒"
        return remainSeconds
    }
    
    @objc func timerStop(_ timer: Timer) {
        duration += 1
        if displayUpdate() <= 0 {
            duration = 0
            timer.invalidate()
        }
    }
}

