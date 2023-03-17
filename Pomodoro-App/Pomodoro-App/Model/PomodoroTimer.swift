//
//  PomodoroTimer.swift
//  Pomodoro-App
//
//  Created by Humberto Rodrigues on 15/03/23.
//

import Foundation

public class PomodoroTimer: Codable {
    var timing: Int = Timing.defaultTime.rawValue
    var interval: Int = Timing.interval.rawValue
    var seconds: Int = Timing.seconds.rawValue
    var pomodoroHistory: Int = 0
    var date: Date = Date.now
    
    var initialTiming: Int {
        return timing * Timing.seconds.rawValue
    }
    
    var initialInterval: Int {
        return interval * Timing.seconds.rawValue
    }
}



