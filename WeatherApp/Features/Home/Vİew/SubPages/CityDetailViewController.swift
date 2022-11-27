//
//  CityDetailViewController.swift
//  WeatherApp
//
//  Created by Mustafa Çiçek on 27.11.2022.
//

import UIKit

class CityDetailViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet private weak var countryLabel: UILabel!
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var celciusLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    
    // MARK: Variables
    var stringLabel: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSelectedCityWeather()
        
    }
    
    // MARK: Private Functions
    private func getSelectedCityWeather() {
        Client.getWeatherSelectedCity(to: stringLabel ?? "") { [weak self] response, error in
            if let response = response {
                self?.countryLabel.text = "Country: \(response.location?.country ?? "")"
                self?.cityLabel.text = "City: \(response.location?.name ?? "")"
                self?.celciusLabel.text = "Temperature: \(response.current?.temperature ?? 0)° C"
                self?.timeLabel.text  = "Time:  \(response.location?.localtime ?? "")"
            }
            else {
                print(error?.localizedDescription)
            }
        }
    }
}
