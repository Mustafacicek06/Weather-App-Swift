//
//  FavoriteListViewController.swift
//  WeatherApp
//
//  Created by Mustafa Çiçek on 27.11.2022.
//

import UIKit

class FavoriteListViewController: UIViewController {
    
    @IBOutlet private var tableView: UITableView!
    
    var favoriteCities: [City] = []
    var cityName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegatesInit()
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getDatas()
        tableView.reloadData()
    }
    
    private func delegatesInit() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    
    private func getDatas() {
         favoriteCities =  CoreDataManager.shared.getCities()
        
    }
}


extension FavoriteListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoriteCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
                var content = cell.defaultContentConfiguration()
        content.text = favoriteCities[indexPath.row].cityName
                cell.contentConfiguration = content
                return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CoreDataManager.shared.deleteCity(deleteItem: favoriteCities[indexPath.row].cityName ?? "")
            favoriteCities.remove(at: indexPath.row)
        
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
        if segue.identifier == "CityDetailViewController" {
            guard let vc = segue.destination as? CityDetailViewController else { return }
            vc.stringLabel = cityName
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cityName = favoriteCities[indexPath.row].cityName
        performSegue(withIdentifier: "CityDetailViewController", sender: nil)
    }
}
