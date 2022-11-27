//
//  AlertManager.swift
//  WeatherApp
//
//  Created by Mustafa Çiçek on 27.11.2022.
//

import UIKit





protocol AlertShowable {
    func showAlert(with error: AlertError,title: String)
}


final class AlertManager: AlertShowable {
    static let shared: AlertManager = .init()
    
    func showAlert(with error: AlertError,title: String)  {
        let alert = UIAlertController(title: title, message: error.description, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        
        DispatchQueue.main.async {
            UIApplication.topViewController()?.present(alert, animated: true)
        }
    }
}

