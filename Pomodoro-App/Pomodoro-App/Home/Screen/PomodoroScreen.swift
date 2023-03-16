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
    
    lazy var lbInformQuantity: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = .white
        lb.textAlignment = .center
        lb.text = ""
        lb.font = UIFont(name: "Chalkboard SE Bold", size: 16)
        return lb
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
        button.setTitleColor(.black, for: .normal)
        button.alpha = 0.2
        button.titleLabel?.font = UIFont(name: "Chalkboard SE Bold", size: 17)
        button.setTitle("Intervalo", for: .normal)
        button.addTarget(self, action: #selector(btClickToInterval), for: .touchUpInside)
        return button
    }()
         
    lazy var lbStopwatch: UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont(name: "Chalkboard SE Bold", size: 50)
        label.text = "00:00"
        label.textAlignment = .center
        return label
    }()
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        callViewcodeMethods()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func delegate(delegate: StopWatchDelegate) {
        self.delegate = delegate
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
        [topView,ivTomatto, lbStopwatch, btStart, btInterval].forEach{
            self.addSubview($0)
        }
        self.topView.addSubview(lbInformQuantity)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            self.topView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.topView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.topView.widthAnchor.constraint(equalToConstant: 300),
            self.topView.heightAnchor.constraint(equalToConstant: 40),
            
            
            self.ivTomatto.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -45),
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
            
            self.btInterval.topAnchor.constraint(equalTo: self.btStart.bottomAnchor, constant: 10),
            self.btInterval.centerXAnchor.constraint(equalTo: self.ivTomatto.centerXAnchor),
            self.btInterval.widthAnchor.constraint(equalToConstant: 100),
            self.btInterval.heightAnchor.constraint(equalToConstant: 50),
            
            self.lbInformQuantity.centerXAnchor.constraint(equalTo: self.topView.centerXAnchor),
            self.lbInformQuantity.centerYAnchor.constraint(equalTo: self.topView.centerYAnchor)
        ])
    }
    
    func extrasFeatures() {
        self.backgroundColor = .white
    }
}

