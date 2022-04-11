//
//  CityWeatherDetailViewModel.swift
//  CityWeather
//
//  Created by Jake Sulkoske on 4/3/22.
//

import Foundation
import SwiftUI

extension CityWeatherDetailView {
    class ViewModel: ObservableObject {
        var cityName: String
        var cityCurrentData: WeatherData
        var cityHourlyData: HourlyWeatherData
        
        let kCurrentWeather = "CURRENT WEATHER"
        let kForecast = "FORECAST"
        let kTemp = "Current temp:"
        let kFeelsLike = "Feels Like:"
        let kLowHigh = "Low/High:"
        let kWind = "Wind:"
        let kAnimationHeight: CGFloat = 100
        
        public init(cityName: String, cityCurrentData: WeatherData, cityHourlyData: HourlyWeatherData)
        {
            self.cityName = cityName
            self.cityCurrentData = cityCurrentData
            self.cityHourlyData = cityHourlyData
        }
        
        var animationName: String {
            guard let temp = cityCurrentData.main?.temp else { return "" }
            if Int(temp) > 60 {
                return "hot"
            } else {
                return "cold"
            }
        }
        
        private var currentWeather: WeatherData {
            return cityCurrentData
        }
        
        private var hourlyWeather: WeatherData {
            return cityHourlyData.list[0]
        }
        
        var currentTemp: String {
            return "\(kTemp) \(Int(currentWeather.main?.temp ?? 0))\(AppConstants.kDegreeSymbol)"
        }
        
        var currentFeelsLike: String {
            return "\(kFeelsLike) \(Int(currentWeather.main?.feels_like ?? 0))\(AppConstants.kDegreeSymbol)"
        }
        
        var currentLowHigh: String {
            return "\(kLowHigh) \(currentHigh)-\(currentLow)"
        }
        
        var currentHigh: String {
            return "\(Int(currentWeather.main?.temp_min ?? 0))\(AppConstants.kDegreeSymbol)"
        }
        
        var currentLow: String {
            return "\(Int(currentWeather.main?.temp_max ?? 0))\(AppConstants.kDegreeSymbol)"
        }
        
        var currentWind: String {
            return "\(kWind) \(Int(currentWeather.wind?.speed ?? 0))\(AppConstants.kMPH)"
        }
        
        var hourlyHeader: String {
            if let dateString = currentWeather.dt_txt,
               let timeString = DateFormatter.convertDateTimeToString(dateString: dateString) {
                return "\(kForecast) FOR \(timeString)"
            } else {
                return kForecast
            }
        }
        
        var hourlyTemp: String {
            return "\(kTemp) \(Int(hourlyWeather.main?.temp ?? 0))\(AppConstants.kDegreeSymbol)"
        }
        
        var hourlyFeelsLike: String {
            return "\(kFeelsLike) \(Int(hourlyWeather.main?.feels_like ?? 0))\(AppConstants.kDegreeSymbol)"
        }
        
        var hourlyWind: String {
            return "\(kWind) \(Int(hourlyWeather.wind?.speed ?? 0))\(AppConstants.kMPH)"
        }
    }
}
