//
//  ViewController.swift
//  Pomodoro-App
//
//  Created by Humberto Rodrigues on 14/03/23.
//

import UIKit
import AVFoundation

final class PomodoroViewController: UIViewController {
    private var controller = PomodoroController()
    private var pomodoroScreen: PomodoroScreen?
    private var timer: Timer?
    private var timerRemaining: Int = 0
    private var player: AVAudioPlayer?

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
            let minutes = timerRemaining / (self.controller.seconds)
            let seconds = timerRemaining % (self.controller.seconds)
            
            self.pomodoroScreen?.lbInformQuantity.text = "\(controller.history.count)º Pomodoro do dia"
            
            self.pomodoroScreen?.btStart.isEnabled = false
            self.pomodoroScreen?.btStart.alpha = 0.3
            
            self.pomodoroScreen?.lbStopwatch.text = String(format: "%02d:%02d", minutes, seconds)
        } else {
            self.timer?.invalidate()
            timerFinished()
        }
        
    }
    
    @objc func timerInterval() {
        timerRemaining -= 1

        if timerRemaining > 0 {
            let minutes = timerRemaining / (self.controller.seconds)
            let seconds = timerRemaining % (self.controller.seconds)
            
            self.pomodoroScreen?.btInterval.isEnabled = false
            self.pomodoroScreen?.btInterval.alpha = 0.2
    
            self.pomodoroScreen?.lbStopwatch.text = String(format: "%02d:%02d", minutes, seconds)
        } else {
            self.timer?.invalidate()
            timerIntervalFinished()
        }
    }
    
    private func timerFinished() {
        startAlarm()
        self.pomodoroScreen?.lbStopwatch.text = "00:00"
        self.pomodoroScreen?.btInterval.isEnabled = true
        self.pomodoroScreen?.btInterval.alpha = 1
    }
    
    
    private func timerIntervalFinished(){
        startAlarm()
        self.pomodoroScreen?.lbStopwatch.text = "00:00"
        self.pomodoroScreen?.btStart.isEnabled = true
        self.pomodoroScreen?.btStart.alpha = 1
    }
    
    private func startAlarm() {
        guard let url = Bundle.main.url(forResource: "alarm", withExtension: "mp3") else {return}
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            self.player = try AVAudioPlayer(contentsOf: url,fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = self.player else {return}
            
            player.delegate = self
            player.play()
        } catch {
            print(error.localizedDescription)
        }
    }
    
   
    
}

extension PomodoroViewController: StopWatchDelegate {
    func letStartTimer() {
        self.timer?.invalidate()
        self.controller.createTimer()
        
        self.timerRemaining = controller.getTiming()
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerStarted), userInfo: nil, repeats: true)
    
    }
    
    func letStartInterval() {
        self.timer?.invalidate()
        self.timerRemaining = controller.getTimingInterval()
        
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerInterval), userInfo: nil, repeats: true)
    }
    
}

extension PomodoroViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop()
    }
}

