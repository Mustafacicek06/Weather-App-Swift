//
//  ViewController.swift
//  WeatherApp
//
//  Created by Mustafa Çiçek on 27.11.2022.
//

import UIKit

final class HomeViewController: UIViewController {

    
    @IBOutlet private weak var cityTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func showDetailButtonOnPressed(_ sender: Any) {
        
        if let fittedText =  cityTextField.text,fittedText.isEmpty {
            AlertManager.shared.showAlert(with: .emptyInput)
        }
        else {
            guard let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: CityDetailViewController.self)) as? CityDetailViewController else { return }
            detailVC.stringLabel = cityTextField.text
                     self.navigationController?.pushViewController(detailVC, animated: true)
            
        }
    }
    

}

