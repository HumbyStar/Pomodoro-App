//
//  PomodoroController.swift
//  Pomodoro-App
//
//  Created by Humberto Rodrigues on 15/03/23.
//

import UIKit

class PomodoroController {
    private var pomodoroTimer: PomodoroTimer?
    var history: [PomodoroTimer] = []
    
    public var minutes: Timing {
        return self.minutes
    }
    
    public var seconds: Timing {
        return self.seconds
    }
    
    public func getTiming() -> Int {
        return self.pomodoroTimer?.initialTiming ?? 0
    }
    
    public func setTiming(new: Int) {
        self.pomodoroTimer?.timing = new
    }
    
    public func setInterval(new: Int) {
        self.pomodoroTimer?.interval = new
    }
    
    public func buildHistory(count: PomodoroTimer) {
        self.history.append(count)
    }
    
    
    
    
}
