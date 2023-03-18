//
//  HistoryScreen.swift
//  Pomodoro-App
//
//  Created by Humberto Rodrigues on 17/03/23.
//

import UIKit

class HistoryScreen: UIView {

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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
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
    public func setTableViewDelegate(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
}

    //MARK: - Extension
extension HistoryScreen: Viewcode {
    func addSubview() {
        addSubview(lbHistory)
        addSubview(tableView)
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            lbHistory.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,constant: 20),
            lbHistory.centerXAnchor.constraint(equalTo: centerXAnchor),
            lbHistory.widthAnchor.constraint(equalToConstant: 200),
            
            tableView.topAnchor.constraint(equalTo: lbHistory.bottomAnchor,constant: 4),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    func extrasFeatures() {
        backgroundColor = .white
    }
}
