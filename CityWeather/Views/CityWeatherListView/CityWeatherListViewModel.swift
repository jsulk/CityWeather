//
//  CityWeatherListViewModel.swift
//  CityWeather
//
//  Created by Jake Sulkoske on 4/3/22.
//

import Foundation
import SwiftUI
import Combine

extension CityWeatherListView {
    class ViewModel: ObservableObject {
        
        @Published var isShowingCurrentForecast: Bool = true
        @Published var currentCityWeatherData: [UUID:CityCurrentData]  = [:]
        @Published var hourlyCityWeatherData: [UUID:CityHourlyData]  = [:]
        @Published private(set) var activeError: LocalizedError?
        
        private let dataManager = CityWeatherDataManager()
        private var cancellables = Set<AnyCancellable>()
        
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
        
        func fetchData(storedCities: FetchedResults<City>, shouldForce: Bool = false) {
            for city in storedCities {
                if let cityId = city.id {
                    if (shouldForce || (self.currentCityWeatherData[cityId] == nil && self.hourlyCityWeatherData[cityId] == nil)) {
                        self.getCurrentData(city: city)
                        self.getHourlyData(city: city)
                    }
                }
            }
        }
        
        private func getCurrentData(city: City) {
            dataManager.getCityCurrentWeatherDataFromCoordinates(city: city)
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
                    receiveValue: { [weak self] (weatherData: WeatherData) in
                        if let self = self {
                            if let cityId = city.id,
                               let cityName = city.name {
                                let weatherData = CityCurrentData(cityName: cityName, currentData: WeatherData(weather: weatherData.weather, main: weatherData.main, wind: weatherData.wind))
                                self.currentCityWeatherData[cityId] = weatherData
                            } else {
                                self.activeError = AppError.internalApp
                            }
                        }
                            
                    })
                .store(in: &cancellables)
        }
        
        private func getHourlyData(city: City) {
            dataManager.getCityHourlyWeatherDataFromCoordinates(city: city)
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
                    receiveValue: { [weak self] (weatherData: HourlyWeatherData) in
                        if let self = self {
                            if let cityId = city.id,
                               let cityName = city.name {
                                let weatherData = CityHourlyData(cityName: cityName, hourlyData: HourlyWeatherData(list: weatherData.list))
                                self.hourlyCityWeatherData[cityId] = weatherData
                            } else {
                                self.activeError = AppError.internalApp
                            }
                        }
                           
                    })
                .store(in: &cancellables)
        }
    }
}
