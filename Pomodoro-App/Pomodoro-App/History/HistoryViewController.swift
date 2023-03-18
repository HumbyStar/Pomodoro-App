//
//  HistoryViewController.swift
//  Pomodoro-App
//
//  Created by Humberto Rodrigues on 17/03/23.
//

import UIKit

final class HistoryViewController: UIViewController {
    
    //MARK: - Private and Public Variable
    private var historyScreen: HistoryScreen?
    public var pomodoros: [PomodoroTimer] = []
    
    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "GMT-3")
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.dateStyle = .medium
        formatter.timeStyle = .full
        return formatter
    }()
    
    //MARK: - Inits
    override func loadView() {
        super.loadView()
        self.historyScreen = HistoryScreen()
        self.view = historyScreen
        
    }
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.historyScreen?.getTableViewDelegate(delegate: self, dataSource: self)
        self.historyScreen?.tableView.reloadData()

    }
}

    //MARK: - Extension
extension HistoryViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pomodoros.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryScreen.cellIdenfitier, for: indexPath)
        
        let dateFormatted = dateFormatter.string(from: pomodoros[indexPath.row].date)
        cell.textLabel?.text = "\(dateFormatted)"
        return cell
    }
}
