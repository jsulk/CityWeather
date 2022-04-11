//
//  AddCityViewModel.swift
//  CityWeather
//
//  Created by Jake Sulkoske on 4/3/22.
//

import Foundation
import SwiftUI
import Combine

extension AddCityView {
    
    class ViewModel: ObservableObject {
        
        @Published var searchResults: [String]?
        @Published var input: String = ""
        @Published private(set) var activeError: LocalizedError?
        
        private let googlePlaceDataManager = GooglePlacesDataManager()
        private let weatherDataManager = CityWeatherDataManager()
        var managedObjectContext = PersistenceController.shared.container.viewContext
        private var cancellables = Set<AnyCancellable>()
        
        var isPresentingAlert: Binding<Bool> {
            return Binding<Bool>(get: {
                return self.activeError != nil
            }, set: { newValue in
                guard !newValue else { return }
                self.activeError = nil
            })
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
        
        func updateSearchResults(value: String) async {
            if !value.isEmpty {
                searchResults = []
                googlePlaceDataManager.getSearchResults(input: input)
                    .receive(on: DispatchQueue.main)
                    .sink(
                        receiveCompletion: { [weak self] value in
                            guard let self = self else { return }
                            switch value {
                            case .failure:
                                self.activeError = AppError.network
                            case .finished:
                                break
                            }
                        },
                        receiveValue: { [weak self] (results: SearchResults) in
                            if let self = self {
                                var searchResults = [String]()
                                for result in results.predictions {
                                    searchResults.append(result.structured_formatting.main_text)
                                }
                                self.searchResults = searchResults
                            }
                        })
                    .store(in: &cancellables)
            } else {
                searchResults = []
            }
        }
        
        func getCityDataForSelectedCityString(_ result: String, completion: @escaping (() -> Void)) {
            weatherDataManager.getCityDataFromCityNameString(cityString: result)
                .receive(on: DispatchQueue.main)
                .sink(
                    receiveCompletion: { [weak self] value in
                        guard let self = self else { return }
                        switch value {
                        case .failure:
                            self.activeError = AppError.network
                        case .finished:
                            break
                        }
                    },
                    receiveValue: { [weak self] (cityData: [CityData]) in
                        if let self = self {
                            if !cityData.isEmpty {
                                self.addCityToAppStorage(city: cityData[0])
                            } else {
                                self.activeError = AppError.network
                            }
                            completion()
                        }
                        
                    })
                .store(in: &cancellables)
        }
    }
}
