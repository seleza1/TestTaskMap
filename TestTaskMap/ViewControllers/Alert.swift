//
//  Alert.swift
//  TestTaskMap
//
//  Created by user on 22.11.2022.
//

import UIKit

extension UIViewController {
    func alertAddAdress(title: String, placeholer: String, completionHandler: @escaping (String)-> Void) {
        
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "Ok", style: .default) { (action) in
            
            let tfTextField = alertController.textFields?.first
            guard let text = tfTextField?.text else { return }
            completionHandler(text)
        }
        
        alertController.addTextField {(tf) in
            tf.placeholder = placeholer
        }
        
        let alertCancel = UIAlertAction(title: "Cancel", style: .default) { _ in
        }
        
        alertController.addAction(alertOk)
        alertController.addAction(alertCancel )
        
        present(alertController, animated: true)
    }
    
    func alertError(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertOk = UIAlertAction(title: "Ok", style: .default)
        
        alertController.addAction(alertOk)
        
        present(alertController, animated: true)
    }
}
