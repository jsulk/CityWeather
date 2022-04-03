//
//  CityWeatherApp.swift
//  CityWeather
//
//  Created by Jake Sulkoske on 4/2/22.
//

import SwiftUI

@main
struct CityWeatherApp: App {
    
    @StateObject private var persistentDataManager = PersistentDataManager()
    
    var body: some Scene {
        WindowGroup {
            CityWeatherListView()
                .environment(\.managedObjectContext, persistentDataManager.cityContainer.viewContext)
        }
    }
}
