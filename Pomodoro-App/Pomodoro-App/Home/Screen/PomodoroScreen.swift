//
//  swift
//  Pomodoro-App
//
//  Created by Humberto Rodrigues on 14/03/23.
//

import UIKit

class PomodoroScreen: UIView{
    
    //MARK: - Private Variables
    private weak var stopWatchDelegate: StopWatchDelegate?
    private weak var pomodoroConfigurationDelegate: PomodoroConfigurationDelegate?
    private weak var checkHistoryDelegate: CheckHistoryDelegate?
    
    //MARK: - Lazy Variables
    lazy var topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.backgroundColor = .red
        return view
    }()
    
    lazy var btSetup: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
        bt.tintColor = .white
        bt.addTarget(self, action: #selector(btSetConfig), for: .touchUpInside)
        return bt
    }()
    
    lazy var btHistory: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setImage(UIImage(systemName: "tray.full.fill"), for: .normal)
        bt.tintColor = .white
        bt.addTarget(self, action: #selector(btTapHistory), for: .touchUpInside)
        return bt
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
        button.isEnabled = false
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
     
    //MARK: - Init and Required Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        callViewcodeMethods()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    public func setupButtonsToTimeStarted(minutes:Int, seconds:Int){
        btSetup.isEnabled = false
        btSetup.alpha = 0.6
        btStart.isEnabled = false
        btStart.alpha = 0.3
        btInterval.isEnabled = false
        btInterval.alpha = 0.2
        btHistory.isEnabled = false
        btHistory.alpha = 0.6
        lbStopwatch.text = String(format: "%02d:%02d", minutes, seconds)
    }
    
    public func setupButtonsToTimeIntervalStarted(minutes:Int, seconds:Int){
        btSetup.isEnabled = false
        btSetup.alpha = 0.6
        btInterval.isEnabled = false
        btInterval.alpha = 0.2
        btHistory.isEnabled = false
        btHistory.alpha = 0.6
        lbStopwatch.text = String(format: "%02d:%02d", minutes, seconds)
    }
    
    public func setupButtonsToTimerfinished(){
        btSetup.isEnabled = true
        btSetup.alpha = 1
        lbStopwatch.text = "00:00"
        btInterval.isEnabled = true
        btInterval.alpha = 1
        btHistory.isEnabled = true
        btHistory.alpha = 1
    }
    
    public func setupButtonsToTimerIntervalFinished(){
        btSetup.isEnabled = true
        btSetup.alpha = 1
        lbStopwatch.text = "00:00"
        btStart.isEnabled = true
        btStart.alpha = 1
        btHistory.isEnabled = true
        btHistory.alpha = 1
    }
    
    //MARK: - Methods Delegates
    public func stopWatchDelegate(delegate: StopWatchDelegate) {
        stopWatchDelegate = delegate
    }
    
    public func pomodoroConfigurationDelegate(delegate: PomodoroConfigurationDelegate){
        pomodoroConfigurationDelegate = delegate
    }
    
    public func checkHistoryDelegate(delegate: CheckHistoryDelegate) {
        checkHistoryDelegate = delegate
    }
    
    @objc func btClickToStart() {
        stopWatchDelegate?.letStartTimer()
    }
    
    @objc func btClickToInterval() {
        stopWatchDelegate?.letStartInterval()
    }
    
    @objc func btSetConfig() {
        pomodoroConfigurationDelegate?.setConfiguration()
    }
    
    @objc func btTapHistory() {
        checkHistoryDelegate?.openHistory()
    }
    
}

    //MARK: - Extensions
extension PomodoroScreen: Viewcode {
    func addSubview() {
        [topView,ivTomatto, lbStopwatch, btStart, btInterval].forEach{
            addSubview($0)
        }
        topView.addSubview(lbInformQuantity)
        topView.addSubview(btSetup)
        topView.addSubview(btHistory)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            topView.centerXAnchor.constraint(equalTo: centerXAnchor),
            topView.widthAnchor.constraint(equalToConstant: 300),
            topView.heightAnchor.constraint(equalToConstant: 40),
            
            
            ivTomatto.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -45),
            ivTomatto.centerXAnchor.constraint(equalTo: centerXAnchor),
            ivTomatto.widthAnchor.constraint(equalToConstant: 250),
            ivTomatto.heightAnchor.constraint(equalToConstant: 250),
            
            lbStopwatch.topAnchor.constraint(equalTo: ivTomatto.bottomAnchor,constant: 50),
            lbStopwatch.widthAnchor.constraint(equalTo: ivTomatto.widthAnchor),
            lbStopwatch.centerXAnchor.constraint(equalTo: ivTomatto.centerXAnchor),
            lbStopwatch.heightAnchor.constraint(equalToConstant: 50),
            
            btStart.topAnchor.constraint(equalTo: lbStopwatch.bottomAnchor, constant: 40),
            btStart.centerXAnchor.constraint(equalTo: ivTomatto.centerXAnchor),
            btStart.widthAnchor.constraint(equalToConstant: 100),
            btStart.heightAnchor.constraint(equalToConstant: 50),
            
            btInterval.topAnchor.constraint(equalTo: btStart.bottomAnchor, constant: 10),
            btInterval.centerXAnchor.constraint(equalTo: ivTomatto.centerXAnchor),
            btInterval.widthAnchor.constraint(equalToConstant: 100),
            btInterval.heightAnchor.constraint(equalToConstant: 50),
            
            lbInformQuantity.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            lbInformQuantity.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            
            btSetup.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            btSetup.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -10),
            
            btHistory.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            btHistory.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 10)
        ])
    }
    
    func extrasFeatures() {
        backgroundColor = .white
    }
}

