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
    public var controller = PomodoroController()
    
    //MARK: - Inits
    override func loadView() {
        super.loadView()
        historyScreen = HistoryScreen()
        view = historyScreen
        
    }
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        historyScreen?.setTableViewDelegate(delegate: self, dataSource: self)
        historyScreen?.tableView.reloadData()
        
    }
}

//MARK: - Extension
extension HistoryViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller.getSizeHistory
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let pomodoro = controller.getContentHistory(index: indexPath.row)
        let dateFormatted = pomodoro.date.formatDate()
        cell.textLabel?.text = "\(dateFormatted)"
        return cell
    }
}
