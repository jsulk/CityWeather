//
//  HourlyForecastRowModel.swift
//  CityWeather
//
//  Created by Jake Sulkoske on 4/3/22.
//

import Foundation

extension HourlyForecastRow {
    
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
        
        var futureTemp: String? {
            if let futureForecaseTemp = cityHourlyData?.hourlyData.list[0].main?.temp {
                return "\(Int(futureForecaseTemp))\(AppConstants.kDegreeSymbol)"
            } else {
                return nil
            }
        }
        
        var convertedForecastTime: String? {
            if let futureForecastTime = cityHourlyData?.hourlyData.list[0].dt_txt,
               let convertedForecastTime = DateFormatter.convertDateTimeToString(dateString: futureForecastTime) {
                return convertedForecastTime
            } else {
                return nil
            }
        }
    }
}
