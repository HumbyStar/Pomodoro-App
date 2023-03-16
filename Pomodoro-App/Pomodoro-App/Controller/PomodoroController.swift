//
//  PomodoroController.swift
//  Pomodoro-App
//
//  Created by Humberto Rodrigues on 15/03/23.
//

import UIKit

class PomodoroController {
    private var pomodoroTimer: PomodoroTimer?
    public var history: [PomodoroTimer] = []

    public var minutes: Int {
        return self.pomodoroTimer?.timing ?? 0
    }
    
    public var date: Date {
        return self.pomodoroTimer?.date ?? Date()
    }
    
    public var seconds: Int {
        return self.pomodoroTimer?.seconds ?? 0
    }
    
    public func getTiming() -> Int {
        return self.pomodoroTimer?.initialTiming ?? 0
    }
    
    public func getTimingInterval() -> Int {
        return self.pomodoroTimer?.initialInterval ?? 0
    }
    
    public func setTiming(new: Int) {
        self.pomodoroTimer?.timing = new
    }
    
    public func setInterval(new: Int) {
        self.pomodoroTimer?.interval = new
    }
    
    public func createTimer() {
        self.pomodoroTimer = PomodoroTimer()
        self.savePomodoro()
    }
    
    public func savePomodoro() {
        let pomodoro = PomodoroTimer()
        self.history.append(pomodoro)
    }
}
