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
        var cityCurrentData: CityCurrentData?
        var cityHourlyData: CityHourlyData?
        
        public init(cityName: String, cityCurrentData: CityCurrentData?, cityHourlyData: CityHourlyData?) {
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
            if let temp = cityCurrentData?.currentData.main?.temp {
                return "Temp: \(Int(temp))\(AppConstants.kDegreeSymbol)"
            }
            return nil
        }
        
        var wind: String? {
            if let wind = cityCurrentData?.currentData.wind?.speed {
                return "Wind: \(Int(wind))\(AppConstants.kMPH)"
            }
            return nil
        }
    }
}
