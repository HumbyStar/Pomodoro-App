//
//  Alert.swift
//  Pomodoro-App
//
//  Created by Humberto Rodrigues on 16/03/23.
//

import UIKit

class Alert {
    var controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func emiteSetupAlert(completion: @escaping newTimeAndInterval) {
        let alertController = UIAlertController(title: "Ajustar tempo", message: "Digite o tempo para ajustar o pomodoro", preferredStyle: .alert)
        
        alertController.addTextField { (textfield) in
            textfield.placeholder = "Digite o tempo da contagem"
            textfield.keyboardType = .numberPad
        }
        
        alertController.addTextField{ (textfield) in
            textfield.placeholder = "Digite o tempo de intervalo"
        }
        
        let confirmAction = UIAlertAction(title: "Confirmar", style: .default) { action in
            let newTimer = alertController.textFields?[0].text
            let newInterval = alertController.textFields?[1].text
            
            guard let newTimer = Int(newTimer ?? ""), let newInterval = Int(newInterval ?? "") else {return}
            completion(newTimer,newInterval)
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
        alertController.view.tintColor = .black
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.controller.present(alertController, animated: true)
    }
    
    func emiteAdjustInterval(completion: @escaping newInterval) {
        let alertController = UIAlertController(title: "Este é 4º Pomodoro de 25 minutos", message: "Deseja aumentar o intervalo para 10 minutos ?", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Aumentar Intervalo", style: .default) { _ in
            completion()
        }
        let cancelAction = UIAlertAction(title: "Não Obrigado", style: .cancel)
        alertController.view.tintColor = .black
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.controller.present(alertController, animated: true)
    }
    
}
