//
//  HourlyForecastRowModel.swift
//  CityWeather
//
//  Created by Jake Sulkoske on 4/3/22.
//

import Foundation

extension HourlyForecastRow {
    
    class ViewModel: ObservableObject {
        
        var cityCurrentData: CityCurrentData
        var cityHourlyData: CityHourlyData
        
        public init(cityCurrentData: CityCurrentData, cityHourlyData: CityHourlyData) {
            self.cityCurrentData = cityCurrentData
            self.cityHourlyData = cityHourlyData
        }
        
        var cityName: String {
            self.cityCurrentData.cityName
        }
        
        var futureTemp: String? {
            if let futureForecaseTemp = cityHourlyData.hourlyData.list[0].main?.temp {
                return "\(Int(futureForecaseTemp))\(AppConstants.kDegreeSymbol)"
            } else {
                return nil
            }
        }
        
        var convertedForecastTime: String? {
            if let futureForecastTime = cityHourlyData.hourlyData.list[0].dt_txt,
               let convertedForecastTime = DateFormatter.convertDateTimeToString(dateString: futureForecastTime) {
                return convertedForecastTime
            } else {
                return nil
            }
        }
    }
}
