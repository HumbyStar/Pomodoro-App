//
//  PomodoroScreen.swift
//  Pomodoro-App
//
//  Created by Humberto Rodrigues on 14/03/23.
//

import UIKit

class PomodoroScreen: UIView{
    
    private weak var delegate: StopWatchDelegate?
    
    lazy var topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.backgroundColor = .red
        return view
    }()
    
    lazy var backgroundTopView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.backgroundColor = .red
        view.alpha = 0.6
        return view
    }()
        
    lazy var ivTomatto: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "tomatto")
        return imageView
    }()
         
    lazy var btStart: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Chalkboard SE Bold", size: 17)
        button.setTitle("Começar", for: .normal)
        button.addTarget(self, action: #selector(btClickToStart), for: .touchUpInside)
        return button
    }()
    
    lazy var btInterval: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Chalkboard SE Bold", size: 17)
        button.setTitle("Intervalo", for: .normal)
        button.isHidden = true
        button.addTarget(self, action: #selector(btClickToInterval), for: .touchUpInside)
        return button
    }()
         
    lazy var lbStopwatch: UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont(name: "Chalkboard SE Bold", size: 50)
        label.text = "25:00"
        label.textAlignment = .center
        return label
    }()
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        callViewcodeMethods()
    }
    
    public func delegate(delegate: StopWatchDelegate) {
        self.delegate = delegate
    }
     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    @objc func btClickToStart() {
        self.delegate?.letStartTimer()
    }
    
    @objc func btClickToInterval() {
        self.delegate?.letStartInterval()
    }
    
}

extension PomodoroScreen: Viewcode {
    func addSubview() {
        [topView, backgroundTopView ,ivTomatto, lbStopwatch, btStart].forEach{
            self.addSubview($0)
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            self.topView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.topView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            self.topView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            self.topView.heightAnchor.constraint(equalToConstant: 40),
            
            self.backgroundTopView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.backgroundTopView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            self.backgroundTopView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            self.backgroundTopView.heightAnchor.constraint(equalToConstant: 40),
            
            self.ivTomatto.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -30),
            self.ivTomatto.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.ivTomatto.widthAnchor.constraint(equalToConstant: 250),
            self.ivTomatto.heightAnchor.constraint(equalToConstant: 250),
            
            self.lbStopwatch.topAnchor.constraint(equalTo: self.ivTomatto.bottomAnchor,constant: 50),
            self.lbStopwatch.widthAnchor.constraint(equalTo: self.ivTomatto.widthAnchor),
            self.lbStopwatch.centerXAnchor.constraint(equalTo: self.ivTomatto.centerXAnchor),
            self.lbStopwatch.heightAnchor.constraint(equalToConstant: 50),
            
            self.btStart.topAnchor.constraint(equalTo: self.lbStopwatch.bottomAnchor, constant: 40),
            self.btStart.centerXAnchor.constraint(equalTo: self.ivTomatto.centerXAnchor),
            self.btStart.widthAnchor.constraint(equalToConstant: 100),
            self.btStart.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func extrasFeatures() {
        self.backgroundColor = .white
    }
}

