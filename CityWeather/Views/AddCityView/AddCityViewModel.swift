//
//  AddCityViewModel.swift
//  CityWeather
//
//  Created by Jake Sulkoske on 4/3/22.
//

import Foundation

extension AddCityView {
    
    class ViewModel: ObservableObject {
        
        @Published var searchResults: [String]?
        @Published var input: String = ""
        
        private let googlePlaceDataManager = GooglePlacesDataManager()
        private let weatherDataManager = CityWeatherDataManager()
        var managedObjectContext = PersistenceController.shared.container.viewContext
        
        func updateSearchResults(value: String) async {
            if !value.isEmpty {
                searchResults = []
                let newResults = await googlePlaceDataManager.getSearchResults(input: input)
                DispatchQueue.main.async {
                    self.searchResults = newResults
                }
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
            await weatherDataManager.getCityDataFromCityNameString(cityString:result, completion: { city in
                self.addCityToAppStorage(city: city)
                completion()
            })
        }
    }
}
