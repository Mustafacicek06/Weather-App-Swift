//
//  CoreDataManager.swift
//  WeatherApp
//
//  Created by Mustafa Çiçek on 27.11.2022.
//
import CoreData
import UIKit

enum CoreDataKeys: String {
    case cityName

}

final class CoreDataManager {
    static let shared = CoreDataManager()
    private let managedContext: NSManagedObjectContext!
    
    private init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    func saveCity(cityName: String) -> City? {
        let entity = NSEntityDescription.entity(forEntityName: "City", in: managedContext)!
        let city = NSManagedObject(entity: entity, insertInto: managedContext)
        city.setValue(cityName, forKeyPath: CoreDataKeys.cityName.rawValue)

        
        do {
            try managedContext.save()
            return city as? City
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return nil
    }
    
    func getCities() -> [City] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "City")
        do {
            let cities = try managedContext.fetch(fetchRequest)
            return cities as! [City]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return []
    }
    
    func deleteCity(deleteItem: String) {
        getCities().forEach { city in
            if city.cityName == deleteItem {
                managedContext.delete(city)
                try! managedContext.save()
                
            }
        }
    }
     
}
