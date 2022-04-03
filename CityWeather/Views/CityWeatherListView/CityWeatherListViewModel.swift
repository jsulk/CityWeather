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
        
        func fetchData(storedCities: FetchedResults<City>) async {
            for city in storedCities {
                if let cityId = city.id,
                   currentCityWeatherData[cityId] == nil {
                    let currentWeatherData = await dataManager.getCityCurrentWeatherData(city: city)
                    let hourlyWeatherData = await dataManager.getCityHourlyWeatherData(city: city)
                    DispatchQueue.main.async {
                        self.currentCityWeatherData[cityId] = currentWeatherData
                        self.hourlyCityWeatherData[cityId] = hourlyWeatherData
                    }
                }
            }
        }
    }
}
