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
    
    //MARK: - Private Variables and constants
    private var controller = PomodoroController()
    private var pomodoroScreen = PomodoroScreen()
    private var timer: Timer?
    private var timerRemaining: Int = 0
    private var player: AVAudioPlayer?
    private var alert: AlertService?
    private let center = UNUserNotificationCenter.current()
    
    //MARK: - Inits
    override func loadView() {
        super.loadView()
        view = pomodoroScreen
    }
    
    //MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emiteNotificationAuthorization()
        controller.loadHistory()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callDelegates()
        NotificationCenter.default.addObserver(self, selector: #selector(updateTimerWhenAppReturnsToForeground), name: NSNotification.Name(Notification.refresh.rawValue), object: nil)
        
    }
    
    //MARK: - Methods
    private func callDelegates() {
        alert = AlertService(controller: self)
        pomodoroScreen.stopWatchDelegate(delegate: self)
        pomodoroScreen.pomodoroConfigurationDelegate(delegate: self)
        pomodoroScreen.checkHistoryDelegate(delegate: self)
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
        var title = "Intervalo Finalizado"
        var body = "Vamos começar um novo pomodoro?"
        var timeInterval = controller.getTimingInterval()
        var identifier = "Interval"
        
        if pomodoroScreen.btStart.isEnabled{
            title = "Pomodoro finalizado"
            body = "Hora do intervalo, descanse um pouco"
            timeInterval = controller.getTiming()
            identifier = "Pomodoro"
        }
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timeInterval), repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        center.add(request) { error in
            if let error = error {
                print("Error to build a notification \(error.localizedDescription)")
            }
        }
        
    }
    
    @objc private func updateTimerWhenAppReturnsToForeground() {
        guard let backgroundTime = UserDefaults.standard.object(forKey: Notification.backgroundTime.rawValue) as? Date else {return}
        let timePassedInBackground = Date().timeIntervalSince(backgroundTime)
        timerRemaining -= Int(timePassedInBackground)
    }
    
    @objc private func timerStarted() {
        timerRemaining -= 1
        
        if timerRemaining > 0 {
            let minutes = timerRemaining / (controller.seconds)
            let seconds = timerRemaining % (controller.seconds)
            let sizeHistory = controller.getSizeHistory
            
            pomodoroScreen.lbInformQuantity.text = "\(sizeHistory)º Pomodoro do dia"
            pomodoroScreen.setupButtonsToTimeStarted(minutes: minutes, seconds: seconds)
        } else {
            startAlarm()
            timerFinished()
        }
        
    }
    
    @objc private func timerIntervalStarted() {
        timerRemaining -= 1
        
        if timerRemaining > 0 {
            let minutes = timerRemaining / (controller.seconds)
            let seconds = timerRemaining % (controller.seconds)
            pomodoroScreen.setupButtonsToTimeIntervalStarted(minutes: minutes, seconds: seconds)
        } else {
            startAlarm()
            timerIntervalFinished()
        }
    }
    
    private func timerFinished() {
        timer?.invalidate()
        pomodoroScreen.setupButtonsToTimerfinished()
        whichPomodoro()
    }
    
    
    private func timerIntervalFinished(){
        timer?.invalidate()
        pomodoroScreen.setupButtonsToTimerIntervalFinished()
    }
    
    private func startAlarm() {
        guard let url = Bundle.main.url(forResource: "alarm", withExtension: "mp3") else {return}
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url,fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else {return}
            player.volume = 0.1
            player.delegate = self
            player.play()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func whichPomodoro() {
        let pomodoro = controller.getSizeHistory
        var count = 0
        
        for x in 0...pomodoro - 1 {
            let pomodoro = controller.getContentHistory(index: x)
            if pomodoro.timing == Timing.defaultTime.rawValue {
                count += 1
            }
            if count == Timing.defaultMaxRepeat.rawValue {
                break
            }
        }
        if count == Timing.defaultMaxRepeat.rawValue {
            alert?.AlertIntervalTurnUp {
                self.controller.setInterval(new: Timing.suggestedInterval.rawValue)
            }
        }
    }
}

//MARK: - Extensions
extension PomodoroViewController: StopWatchDelegate {
    func letStartTimer() {
        controller.addPomodoroInHistory()
        buildNotification()
        
        timerRemaining = controller.getTiming()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerStarted), userInfo: nil, repeats: true)
    }
    
    func letStartInterval() {
        timerRemaining = controller.getTimingInterval()
        buildNotification()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerIntervalStarted), userInfo: nil, repeats: true)
    }
    
}

extension PomodoroViewController: PomodoroConfigurationDelegate {
    func setConfiguration() {
        alert?.alertChangeTimer(completion: {timing,interval in
            if let timing = timing {
                self.controller.setTiming(new: timing)
            } else if let interval = interval {
                self.controller.setInterval(new: interval)
            }
        })
    }
}

extension PomodoroViewController: CheckHistoryDelegate {
    func openHistory() {
        let historyViewController = HistoryViewController()
        historyViewController.controller = controller
        present(historyViewController, animated: true)
    }
}

extension PomodoroViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop()
    }
}

extension PomodoroViewController: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if UIApplication.shared.applicationState == .background {
            let id = response.notification.request.identifier
            if id == "Pomodoro" {
                timerFinished()
            } else {
                timerIntervalFinished()
            }
        }
    }
}

