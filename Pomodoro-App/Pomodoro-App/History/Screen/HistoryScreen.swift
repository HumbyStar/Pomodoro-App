//
//  HistoryScreen.swift
//  Pomodoro-App
//
//  Created by Humberto Rodrigues on 17/03/23.
//

import UIKit

class HistoryScreen: UIView {
    
    //MARK: - Variable Static
    static let cellIdenfitier = "HistoryScreen"
    
    //MARK: - Lazy Variables
    lazy var lbHistory: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "History"
        lb.textAlignment = .center
        lb.font = UIFont(name: "Chalkboard SE Bold", size: 25)
        lb.textColor = .red
        return lb
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: HistoryScreen.cellIdenfitier)
        return tableView
    }()
    
    //MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        callViewcodeMethods()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Method
    public func getTableViewDelegate(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        self.tableView.delegate = delegate
        self.tableView.dataSource = dataSource
    }
}

    //MARK: - Extension
extension HistoryScreen: Viewcode {
    func addSubview() {
        self.addSubview(lbHistory)
        self.addSubview(tableView)
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.lbHistory.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,constant: 20),
            self.lbHistory.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.lbHistory.widthAnchor.constraint(equalToConstant: 200),
            
            self.tableView.topAnchor.constraint(equalTo: self.lbHistory.bottomAnchor,constant: 4),
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    func extrasFeatures() {
        self.backgroundColor = .white
    }
}
