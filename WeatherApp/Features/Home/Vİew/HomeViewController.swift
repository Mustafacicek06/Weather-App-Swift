//
//  ViewController.swift
//  WeatherApp
//
//  Created by Mustafa Çiçek on 27.11.2022.
//

import UIKit

final class HomeViewController: UIViewController {

    
    @IBOutlet weak var cityTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("calisti")
    
    }
    
    private func getSelectedCityWeather() {
        if let fittedText =  cityTextField.text,fittedText.isEmpty {
            let alert = UIAlertController(title: "Alert", message: "Gelir alanınız boş. Lütfen eklemek istediğiniz değeri girin", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: {
                return
            }
            )
        }
        else {
            Client.getWeatherSelectedCity(to: cityTextField?.text ?? "") { response, error in
                if let response = response {
                    print(response)
                }
                else {
                    print(error?.localizedDescription)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "toDetailCity" {
                
            }
        }
    
    @IBAction func showDetailButtonOnPressed(_ sender: Any) {
        
        getSelectedCityWeather()
    }
    

}

