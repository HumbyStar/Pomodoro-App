//
//  ViewController.swift
//  Pomodoro-App
//
//  Created by Humberto Rodrigues on 14/03/23.
//

import UIKit

class PomodoroViewController: UIViewController {

    private var pomodoroScreen: PomodoroScreen?
    
    override func loadView() {
        super.loadView()
        self.pomodoroScreen = PomodoroScreen()
        self.view = pomodoroScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

