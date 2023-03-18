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
    private var history: [PomodoroTimer] = []
    static let identifier = "PomodoroData"
    public var userDefaults = UserDefaults.standard

    //MARK: - Computed properties
    public var minutes: Int {
        return pomodoroTimer.timing
    }
    
    public var getSizeHistory: Int {
        return history.count
    }
    
    public var date: Date {
        return pomodoroTimer.date
    }
    
    public var seconds: Int {
        return pomodoroTimer.seconds
    }
    
    //MARK: - Publics Methods
    public func getContentHistory(index: Int) -> PomodoroTimer{
        return history[index]
    }
    
    public func getTiming() -> Int {
        return pomodoroTimer.initialTiming
    }
    
    public func getTimingInterval() -> Int {
        return pomodoroTimer.initialInterval
    }
    
    public func setTiming(new: Int) {
        pomodoroTimer.timing = new
    }

    public func setInterval(new: Int) {
        pomodoroTimer.interval = new
    }
    
    public func addPomodoroInHistory() {
        history.append(pomodoroTimer)
        saveHistory()
    }
    
    public func loadHistory() {
        if let dataHistory = userDefaults.data(forKey: Self.identifier) {
            if let loadedHistory = try? JSONDecoder().decode([PomodoroTimer].self, from: dataHistory) {
                validDate(loadedHistory: loadedHistory)
            }
        }
    }
    
    //MARK: - Privates Methods
    private func clearHistory() {
        history = []
        userDefaults.removeObject(forKey: Self.identifier)
        saveHistory()
    }
    
    private func saveHistory() {
        do {
            let json = try JSONEncoder().encode(history)
            userDefaults.set(json, forKey: Self.identifier)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    private func validDate(loadedHistory: [PomodoroTimer]) {
        if let lastPomodoro = loadedHistory.last, !Calendar.current.isDateInToday(lastPomodoro.date) {
            clearHistory()
        } else {
            history = loadedHistory
        }
    }
}
