//
//  CityListViewModel.swift
//  CityWeather
//
//  Created by Jake Sulkoske on 4/3/22.
//

import Foundation
import CoreData
import SwiftUI

extension CityListView {
    
    class ViewModel: ObservableObject {
        
        var managedObjectContext = PersistenceController.shared.container.viewContext
        
        @Published var showingDetail = false
        
        let kNoCities: String = "Add a city by tapping the Add City button!"
        let kSavedCities: String = "Saved Cities"
        let kAddCity: String = "Add City"
        let kHorizontalPadding: CGFloat = 16
        
        func deleteCityFromStorage(city: City) {
            managedObjectContext.delete(city)
            PersistenceController.shared.save()
        }
    }
}
