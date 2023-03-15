//
//  ViewController.swift
//  Pomodoro-App
//
//  Created by Humberto Rodrigues on 14/03/23.
//

import UIKit

final class PomodoroViewController: UIViewController {

    private var pomodoroScreen: PomodoroScreen?
    private var timer: Timer?
    private var timerRemaining: Int = 0

    override func loadView() {
        super.loadView()
        self.pomodoroScreen = PomodoroScreen()
        self.view = pomodoroScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pomodoroScreen?.delegate(delegate: self)
    }
    
    @objc func timerStarted() {
        timerRemaining -= 1
        
        if timerRemaining > 0 {
            let minutes = timerRemaining / Timing.seconds.rawValue
            let seconds = timerRemaining % Timing.seconds.rawValue
            self.pomodoroScreen?.lbStopwatch.text = "\(minutes):\(seconds)"
        } else {
            timerFinished()
        }
    }
    
    private func timerFinished() {
        self.pomodoroScreen?.lbStopwatch.text = "5:00"
        self.pomodoroScreen?.btStart.setTitle("Intervalo", for: .normal)
    }
}

extension PomodoroViewController: StopWatchDelegate {
    func letStartTimer() {
        self.timer?.invalidate()
        self.timerRemaining = 0 //MARK: Editar
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerStarted), userInfo: nil, repeats: true)
    }
    
    func letStartInterval() {
        
    }
    
}

