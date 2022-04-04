//
//  AddCityViewModel.swift
//  CityWeather
//
//  Created by Jake Sulkoske on 4/3/22.
//

import Foundation
import SwiftUI

extension AddCityView {
    
    class ViewModel: ObservableObject {
        
        @Published var searchResults: [String]?
        @Published var input: String = ""
        @Published private(set) var activeError: LocalizedError?
        
        private let googlePlaceDataManager = GooglePlacesDataManager()
        private let weatherDataManager = CityWeatherDataManager()
        var managedObjectContext = PersistenceController.shared.container.viewContext
        
        var isPresentingAlert: Binding<Bool> {
            return Binding<Bool>(get: {
                return self.activeError != nil
            }, set: { newValue in
                guard !newValue else { return }
                self.activeError = nil
            })
        }
        
        func updateSearchResults(value: String) async {
            if !value.isEmpty {
                searchResults = []
                await googlePlaceDataManager.getSearchResults(input: input, completion: { results, error in
                    DispatchQueue.main.async {
                        if let error = error {
                            self.activeError = error
                        } else {
                            self.searchResults = results
                        }
                    }
                })
            } else {
                searchResults = []
            }
        }
        
        func addCityToAppStorage(city: CityData?) {
            if let city = city {
                let newCity = City(context: managedObjectContext)
                newCity.id = UUID()
                newCity.name = city.name
                newCity.lat = city.lat
                newCity.lon = city.lon

                PersistenceController.shared.save()
            }
        }
        
        func getCityDataForSelectedCityString(_ result: String, completion: @escaping (() -> Void)) async {
            await weatherDataManager.getCityDataFromCityNameString(cityString:result, completion: { city, error in
                DispatchQueue.main.async {
                    if let error = error {
                        self.activeError = error
                    } else {
                        self.addCityToAppStorage(city: city)
                    }
                    completion()
                }
            })
        }
    }
}
