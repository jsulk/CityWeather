//
//  CurrentForecastRowModel.swift
//  CityWeather
//
//  Created by Jake Sulkoske on 4/3/22.
//

import Foundation

extension CurrentForecastRow {
    
    class ViewModel: ObservableObject {
        
        var cityName: String
        var cityCurrentData: WeatherData?
        var cityHourlyData: HourlyWeatherData?
        
        public init(cityName: String, cityCurrentData: WeatherData?, cityHourlyData: HourlyWeatherData?) {
            self.cityName = cityName
            self.cityCurrentData = cityCurrentData
            self.cityHourlyData = cityHourlyData
        }
        
        var rowDisabled: Bool {
            if self.cityCurrentData == nil || self.cityHourlyData == nil {
                return true
            } else {
                return false
            }
        }
        
        var temp: String? {
            if let temp = cityCurrentData?.main?.temp {
                return "Temp: \(Int(temp))\(AppConstants.kDegreeSymbol)"
            }
            return nil
        }
        
        var wind: String? {
            if let wind = cityCurrentData?.wind?.speed {
                return "Wind: \(Int(wind))\(AppConstants.kMPH)"
            }
            return nil
        }
    }
}
