//
//  PersistentDataManager.swift
//  CityWeather
//
//  Created by Jake Sulkoske on 4/3/22.
//

import CoreData
import Foundation

public final class PersistentDataManager: ObservableObject {
    
    let cityContainer = NSPersistentContainer(name: "City")
    
    init() {
        cityContainer.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data Error: \(error.localizedDescription)")
            }
        }
    }
}
