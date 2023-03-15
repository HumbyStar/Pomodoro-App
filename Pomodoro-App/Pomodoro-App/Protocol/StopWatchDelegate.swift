//
//  BeginTimerDelegate.swift
//  Pomodoro-App
//
//  Created by Humberto Rodrigues on 14/03/23.
//

import Foundation

protocol StopWatchDelegate: AnyObject {
    func letStartTimer()
    func letStartInterval()
}
