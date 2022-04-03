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
    }
}
