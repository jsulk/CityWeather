//
//  CurrentForecastRow.swift
//  CityWeather
//
//  Created by Jake Sulkoske on 4/3/22.
//

import SwiftUI

struct CurrentForecastRow: View {
    
    var viewModel: ViewModel
    
    public init(model: ViewModel) {
        self.viewModel = model
    }

    var body: some View {
        NavigationLink(destination: CityWeatherDetailView(model: CityWeatherDetailView.ViewModel(cityCurrentData: self.viewModel.cityCurrentData, cityHourlyData: self.viewModel.cityHourlyData)), label: {
            HStack {
                Text(self.viewModel.cityName)
                
                Spacer()
                
                VStack {
                    tempLabel
                    
                    windLabel
                }
            }
        })
    }
    
    @ViewBuilder
    private var tempLabel: some View {
        if let temp = self.viewModel.temp {
            Text(temp)
        }
    }
    
    @ViewBuilder
    private var windLabel: some View {
        if let wind = self.viewModel.wind {
            Text(wind)
        }
    }
}

struct CurrentForecastRow_Previews: PreviewProvider {
    static var previews: some View {
        CurrentForecastRow(model: CurrentForecastRow.ViewModel(cityCurrentData: CityCurrentData(cityName: "Los Angeles", currentData: WeatherData(weather: [WeatherOverview(id: 0, main: "Rainy", description: "You're going to need an umbrella")], main: Temperature(temp: 0.0, feels_like: 0.0, temp_min: 0.0, temp_max: 0.0), wind: Wind(speed: 0.0, deg: 21))), cityHourlyData: CityHourlyData(cityName: "Los Angeles", hourlyData: HourlyWeatherData(list: [WeatherData(weather: [WeatherOverview(id: 0, main: "Rainy", description: "You're going to need an umbrella")], main: Temperature(temp: 0.0, feels_like: 0.0, temp_min: 0.0, temp_max: 0.0), wind: Wind(speed: 0.0, deg: 21))]))))
    }
}
