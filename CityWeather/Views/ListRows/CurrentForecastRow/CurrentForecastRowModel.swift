//
//  CurrentForecastRowModel.swift
//  CityWeather
//
//  Created by Jake Sulkoske on 4/3/22.
//

import Foundation

public final class CurrentForecastRowModel {
    
    var cityCurrentData: CityCurrentData
    var cityHourlyData: CityHourlyData
    
    public init(cityCurrentData: CityCurrentData, cityHourlyData: CityHourlyData) {
        self.cityCurrentData = cityCurrentData
        self.cityHourlyData = cityHourlyData
    }
    
    var cityName: String {
        self.cityCurrentData.cityName
    }
    
    var temp: String? {
        if let temp = cityCurrentData.currentData.main?.temp {
            return "\(Int(temp))\(AppConstants.kDegreeSymbol)"
        }
        return nil
    }
}
