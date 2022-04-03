//
//  CurrentForecastRow.swift
//  CityWeather
//
//  Created by Jake Sulkoske on 4/3/22.
//

import SwiftUI

struct CurrentForecastRow: View {
    
    var viewModel: CurrentForecastRowModel
    
    public init(model: CurrentForecastRowModel) {
        self.viewModel = model
    }

    var body: some View {
        HStack {
            Text(self.viewModel.cityName)
            
            Spacer()
            
            if let temp = self.viewModel.temp {
                Text(temp)
            }
        }
    }
}

struct CurrentForecastRow_Previews: PreviewProvider {
    static var previews: some View {
        CurrentForecastRow(model: CurrentForecastRowModel(cityCurrentData: CityCurrentData(cityName: "Los Angeles", currentData: WeatherData(weather: [WeatherOverview(id: 0, main: "Rainy", description: "You're going to need an umbrella")], main: Temperature(temp: 0.0, feels_like: 0.0, temp_min: 0.0, temp_max: 0.0), wind: Wind(speed: 0.0, deg: 21))), cityHourlyData: CityHourlyData(cityName: "Los Angeles", hourlyData: HourlyWeatherData(list: [WeatherData(weather: [WeatherOverview(id: 0, main: "Rainy", description: "You're going to need an umbrella")], main: Temperature(temp: 0.0, feels_like: 0.0, temp_min: 0.0, temp_max: 0.0), wind: Wind(speed: 0.0, deg: 21))]))))
    }
}
