//
//  CityWeatherDetailViewModel.swift
//  CityWeather
//
//  Created by Jake Sulkoske on 4/3/22.
//

import Foundation

extension CityWeatherDetailView {
    class ViewModel: ObservableObject {
        var cityCurrentData: CityCurrentData
        var cityHourlyData: CityHourlyData
        
        public init(cityCurrentData: CityCurrentData, cityHourlyData: CityHourlyData)
        {
            self.cityCurrentData = cityCurrentData
            self.cityHourlyData = cityHourlyData
        }
        
        var cityName: String {
            self.cityCurrentData.cityName
        }
    }
}
