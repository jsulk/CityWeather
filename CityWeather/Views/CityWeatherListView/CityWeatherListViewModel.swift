//
//  CityWeatherListViewModel.swift
//  CityWeather
//
//  Created by Jake Sulkoske on 4/3/22.
//

import Foundation
import SwiftUI

extension CityWeatherListView {
    class ViewModel: ObservableObject {
        
        @Published var isShowingCurrentForecast: Bool = true
        @Published var currentCityWeatherData: [UUID:CityCurrentData] = [:]
        @Published var hourlyCityWeatherData: [UUID:CityHourlyData] = [:]
        @Published private(set) var activeError: LocalizedError?
        
        private let dataManager = CityWeatherDataManager()
        
        let kCurrent = "Current"
        let kForecasts = "Forecasts"
        let kHourly = "Hourly"
        let kCities = "Cities"
        let kNoSavedCitiesText = "You don't have any cities saved, yet!"
        let kTabHorizontalPadding: CGFloat = 40
        let kTabBottomPadding: CGFloat = 16
        
        var navTitle: String {
            if isShowingCurrentForecast {
                return kCurrent
            } else {
                return kForecasts
            }
        }
        
        var isPresentingAlert: Binding<Bool> {
            return Binding<Bool>(get: {
                return self.activeError != nil
            }, set: { newValue in
                guard !newValue else { return }
                self.activeError = nil
            })
        }
        
        func fetchData(storedCities: FetchedResults<City>, shouldForce: Bool = false) async {
            for city in storedCities {
                if let cityId = city.id {
                    if (shouldForce || (currentCityWeatherData[cityId] == nil && hourlyCityWeatherData[cityId] == nil)) {
                        await getCurrentData(city: city, cityId: cityId)
                        await getHourlyData(city: city, cityId: cityId)
                    }
                }
            }
        }
        
        private func getCurrentData(city: City, cityId: UUID) async {
            await dataManager.getCityCurrentWeatherDataFromCoordinates(city: city, completion: { currentData, error in
                DispatchQueue.main.async {
                    if let error = error {
                        self.activeError = error
                    } else {
                        self.currentCityWeatherData[cityId] = currentData
                    }
                }
            })
        }
        
        private func getHourlyData(city: City, cityId: UUID) async {
            await dataManager.getCityHourlyWeatherDataFromCoordinates(city: city, completion: { hourlyData, error in
                DispatchQueue.main.async {
                    if let error = error {
                        self.activeError = error
                    } else {
                        self.hourlyCityWeatherData[cityId] = hourlyData
                    }
                }
                
            })
        }
    }
}
