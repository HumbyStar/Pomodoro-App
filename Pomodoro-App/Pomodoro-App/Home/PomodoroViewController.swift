//
//  ViewController.swift
//  Pomodoro-App
//
//  Created by Humberto Rodrigues on 14/03/23.
//

import UIKit
import AVFoundation
import UserNotifications

final class PomodoroViewController: UIViewController {
    private var controller = PomodoroController()
    private var pomodoroScreen: PomodoroScreen?
    private var timer: Timer?
    private var timerRemaining: Int = 0
    private var player: AVAudioPlayer?
    private var alert: Alert?
    private let center = UNUserNotificationCenter.current()

    override func loadView() {
        super.loadView()
        self.pomodoroScreen = PomodoroScreen()
        self.view = pomodoroScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emiteNotificationAuthorization()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callDelegates()
    }
    
    
    private func callDelegates() {
        self.alert = Alert(controller: self)
        self.pomodoroScreen?.stopWatchDelegate(delegate: self)
        self.pomodoroScreen?.pomodoroConfigurationDelegate(delegate: self)
        center.delegate = self
    }
    
    private func emiteNotificationAuthorization() {
        
        center.requestAuthorization(options: [.sound, .alert]) { success, error in
            if let error = error {
                print("Error to get Authorization \(error.localizedDescription)")
            }
        }
    }
    
    private func buildNotification() {
        
        if self.pomodoroScreen?.btStart.isEnabled == true {
            let content = UNMutableNotificationContent()
            content.title = "Pomodoro finalizado"
            content.body = "Hora do intervalo, descanse um pouco"
            content.sound = .default //PERSONALIZAR SOM DEPOIS
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(self.controller.getTiming()), repeats: false)
            let request = UNNotificationRequest(identifier: "Pomodoro", content: content, trigger: trigger)
            
            center.add(request) { error in
                if let error = error {
                    print("Error to build a notification \(error.localizedDescription)")
                }
            }
        } else {
            let content = UNMutableNotificationContent()
            content.title = "Intervalo finalizado"
            content.body = "Vamos começar um novo Pomodoro?"
            content.sound = .default 

            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(self.controller.getTimingInterval()), repeats: false)
            let request = UNNotificationRequest(identifier: "Interval", content: content, trigger: trigger)
            
            center.add(request) { error in
                if let error = error {
                    print("Error to build a notification \(error.localizedDescription)")
                }
            }
        }
    }
    
    @objc func timerStarted() {
        timerRemaining -= 1
        
        if timerRemaining > 0 {
            let minutes = timerRemaining / (self.controller.seconds)
            let seconds = timerRemaining % (self.controller.seconds)
            
            self.pomodoroScreen?.lbInformQuantity.text = "\(controller.history.count)º Pomodoro do dia"
            self.pomodoroScreen?.btSetup.isEnabled = false
            self.pomodoroScreen?.btSetup.alpha = 0.6
            self.pomodoroScreen?.btStart.isEnabled = false
            self.pomodoroScreen?.btStart.alpha = 0.3
            
            self.pomodoroScreen?.lbStopwatch.text = String(format: "%02d:%02d", minutes, seconds)
        } else {
            startAlarm()
            timerFinished()
        }
        
    }
    
    @objc func timerIntervalStarted() {
        timerRemaining -= 1

        if timerRemaining > 0 {
            let minutes = timerRemaining / (self.controller.seconds)
            let seconds = timerRemaining % (self.controller.seconds)
            
            self.pomodoroScreen?.btSetup.isEnabled = false
            self.pomodoroScreen?.btSetup.alpha = 0.6
            self.pomodoroScreen?.btInterval.isEnabled = false
            self.pomodoroScreen?.btInterval.alpha = 0.2
    
            self.pomodoroScreen?.lbStopwatch.text = String(format: "%02d:%02d", minutes, seconds)
        } else {
            startAlarm()
            timerIntervalFinished()
        }
    }
    
    private func timerFinished() {
        self.timer?.invalidate()
        self.pomodoroScreen?.btSetup.isEnabled = true
        self.pomodoroScreen?.btSetup.alpha = 1
        self.pomodoroScreen?.lbStopwatch.text = "00:00"
        self.pomodoroScreen?.btInterval.isEnabled = true
        self.pomodoroScreen?.btInterval.alpha = 1
        self.whichPomodoro()
    }
    
    
    private func timerIntervalFinished(){
        self.timer?.invalidate()
        self.pomodoroScreen?.btSetup.isEnabled = true
        self.pomodoroScreen?.btSetup.alpha = 1
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
    
    private func whichPomodoro() {
        let pomodoro = self.controller.history
        var count = 0
        
        for x in 0...self.controller.history.count - 1 {
            if pomodoro[x].timing == Timing.defaultTime.rawValue {
                count += 1
            }
            if count == Timing.defaultMaxRepeat.rawValue {
                break
            }
        }
        if count == Timing.defaultMaxRepeat.rawValue {
            alert?.emiteAdjustInterval {
                self.controller.setInterval(new: Timing.suggestedInterval.rawValue)
            }
        }
    }
}

extension PomodoroViewController: StopWatchDelegate {
    func letStartTimer() {
        self.controller.savePomodoroHistory()
        self.buildNotification()
        
        self.timerRemaining = controller.getTiming()
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerStarted), userInfo: nil, repeats: true)
    
    }
    
    func letStartInterval() {
        self.timerRemaining = controller.getTimingInterval()
        self.buildNotification()
        
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerIntervalStarted), userInfo: nil, repeats: true)
    }
    
}

extension PomodoroViewController: PomodoroConfigurationDelegate {
    func setConfiguration() {
        alert?.emiteSetupAlert(completion: {timing,interval in
            if let timing = timing {
                self.controller.setTiming(new: timing)
            } else if let interval = interval {
                self.controller.setInterval(new: interval)
            }
        })
    }
}

extension PomodoroViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop()
    }
}

extension PomodoroViewController: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    
        let id = response.notification.request.identifier
        if id == "Pomodoro" {
            self.timerFinished()
        } else {
            self.timerIntervalFinished()
        }
    }
}

