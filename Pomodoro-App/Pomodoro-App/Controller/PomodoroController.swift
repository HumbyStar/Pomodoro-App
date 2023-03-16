//
//  PomodoroController.swift
//  Pomodoro-App
//
//  Created by Humberto Rodrigues on 15/03/23.
//

import UIKit

class PomodoroController {
    private var pomodoroTimer = PomodoroTimer()
    public var history: [PomodoroTimer] = []

    public var minutes: Int {
        return self.pomodoroTimer.timing
    }
    
    public var date: Date {
        return self.pomodoroTimer.date
    }
    
    public var seconds: Int {
        return self.pomodoroTimer.seconds
    }
    
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
    
    public func savePomodoroHistory() {
        self.history.append(pomodoroTimer)
    }
}
