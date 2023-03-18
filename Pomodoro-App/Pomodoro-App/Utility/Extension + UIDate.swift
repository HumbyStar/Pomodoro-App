//
//  Extension + UIDate.swift
//  Pomodoro-App
//
//  Created by Humberto Rodrigues on 18/03/23.
//

import UIKit

extension Date {
    func formatDate() -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "GMT-3")
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.dateStyle = .medium
        formatter.timeStyle = .full
        return formatter.string(from: self)
    }
}
