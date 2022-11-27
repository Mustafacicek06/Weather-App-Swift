//
//  CityDetailViewController.swift
//  WeatherApp
//
//  Created by Mustafa Çiçek on 27.11.2022.
//

import UIKit
import Kingfisher

class CityDetailViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet private weak var countryLabel: UILabel!
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var celciusLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var weatherDescription: UILabel!
    
    // MARK: Variables
    var stringLabel: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Like", style: .plain, target: self, action: #selector(favoriteButtonOnPressed))
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
                
                self?.weatherDescription.text = "Weather Description: \( response.current?.weatherDescriptions?[0] ?? "")"
                
                if let url = URL(string: "\(response.current?.weatherIcons?[0] ?? "not found")" ) {
                    self?.imageView.kf.setImage(with: url)
                                }
            }
            else {
                print(error?.localizedDescription)
            }
        }
    }
    
    // MARK: Actions
    
    @objc func favoriteButtonOnPressed() {
        guard let cityName = cityLabel.text else { return }
        CoreDataManager.shared.saveCity(cityName: cityName)
    }
    
}
