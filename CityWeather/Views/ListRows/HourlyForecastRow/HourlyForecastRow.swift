//
//  HourlyForecastRow.swift
//  CityWeather
//
//  Created by Jake Sulkoske on 4/3/22.
//

import SwiftUI

struct HourlyForecastRow: View {
    
    private var viewModel: HourlyForecastRowModel
    
    public init(model: HourlyForecastRowModel) {
        self.viewModel = model
    }
    
    var body: some View {
        HStack {
            cityNameLabel
            
            Spacer()
            
            futureTemperatureLabel
        }
    }
    
    @ViewBuilder
    private var cityNameLabel: some View {
        Text(self.viewModel.cityName)
    }
    
    @ViewBuilder
    private var futureTemperatureLabel: some View {
        VStack {
            if let futureTemp = self.viewModel.futureTemp,
               let forecastTime = self.viewModel.convertedForecastTime {
                Text(futureTemp)
                Text(forecastTime)
            }
        }
    }
}

struct HourlyForecastRow_Previews: PreviewProvider {
    static var previews: some View {
        HourlyForecastRow(model: HourlyForecastRowModel(cityCurrentData: CityCurrentData(cityName: "Los Angeles", currentData: WeatherData(weather: [WeatherOverview(id: 0, main: "Rainy", description: "You're going to need an umbrella")], main: Temperature(temp: 0.0, feels_like: 0.0, temp_min: 0.0, temp_max: 0.0), wind: Wind(speed: 0.0, deg: 21))), cityHourlyData: CityHourlyData(cityName: "Los Angeles", hourlyData: HourlyWeatherData(list: [WeatherData(weather: [WeatherOverview(id: 0, main: "Rainy", description: "You're going to need an umbrella")], main: Temperature(temp: 0.0, feels_like: 0.0, temp_min: 0.0, temp_max: 0.0), wind: Wind(speed: 0.0, deg: 21))]))))
    }
}
