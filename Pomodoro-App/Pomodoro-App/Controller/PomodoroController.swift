//
//  PomodoroController.swift
//  Pomodoro-App
//
//  Created by Humberto Rodrigues on 15/03/23.
//

import UIKit

final class PomodoroController {
    
    //MARK: - Variables and Constant
    private var pomodoroTimer = PomodoroTimer()
    public var history: [PomodoroTimer] = []
    private static let udIdentifier = "PomodoroData"
    public var ud = UserDefaults.standard

    //MARK: - Computed properties
    public var minutes: Int {
        return self.pomodoroTimer.timing
    }
    
    public var date: Date {
        return self.pomodoroTimer.date
    }
    
    public var seconds: Int {
        return self.pomodoroTimer.seconds
    }
    
    //MARK: - Methods 
    public func getTiming() -> Int {
        return self.pomodoroTimer.initialTiming
    }
    
    public func getTimingInterval() -> Int {
        return self.pomodoroTimer.initialInterval
    }
    
    public func setTiming(new: Int) {
        self.pomodoroTimer.timing = new
    }

    public func setInterval(new: Int) {
        self.pomodoroTimer.interval = new
    }
    
    public func addPomodoroInHistory() {
        self.history.append(pomodoroTimer)
        saveHistory()
    }
    
    private func clearHistory() {
        history = []
        ud.removeObject(forKey: Self.udIdentifier)
        saveHistory()
    }
    
    private func saveHistory() {
        let json = try? JSONEncoder().encode(history)
        ud.set(json, forKey: Self.udIdentifier)
    }
    
    public func loadHistory() {
        if let dataHistory = ud.data(forKey: Self.udIdentifier) {
            if let loadedHistory = try? JSONDecoder().decode([PomodoroTimer].self, from: dataHistory) {
                if let lastPomodoro = loadedHistory.last, !Calendar.current.isDateInToday(lastPomodoro.date) {
                    clearHistory()
                } else {
                    self.history = loadedHistory
                }
            }
        }
    }
    
    
}
