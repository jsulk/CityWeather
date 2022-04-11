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
        NavigationLink(destination: self.destination, label: {
            HStack {
                Text(self.viewModel.cityName)
                
                Spacer()
                
                VStack {
                    tempLabel
                    
                    windLabel
                }
            }
        })
        .frame(height: 40)
        .disabled(viewModel.rowDisabled)
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
    
    @ViewBuilder
    private var destination: some View {
        if let cityCurrentData = self.viewModel.cityCurrentData,
           let cityHourlyData = self.viewModel.cityHourlyData {
            CityWeatherDetailView(model: CityWeatherDetailView.ViewModel(cityCurrentData: cityCurrentData, cityHourlyData: cityHourlyData))
        }
    }
}

struct CurrentForecastRow_Previews: PreviewProvider {
    static var previews: some View {
        CurrentForecastRow(model: CurrentForecastRow.ViewModel(cityName: "Los Angeles", cityCurrentData: CityCurrentData(cityName: "Los Angeles", currentData: WeatherData(weather: [WeatherOverview(id: 0, main: "Rainy", description: "You're going to need an umbrella")], main: Temperature(temp: 0.0, feels_like: 0.0, temp_min: 0.0, temp_max: 0.0), wind: Wind(speed: 0.0, deg: 21))), cityHourlyData: CityHourlyData(cityName: "Los Angeles", hourlyData: HourlyWeatherData(list: [WeatherData(weather: [WeatherOverview(id: 0, main: "Rainy", description: "You're going to need an umbrella")], main: Temperature(temp: 0.0, feels_like: 0.0, temp_min: 0.0, temp_max: 0.0), wind: Wind(speed: 0.0, deg: 21))]))))
    }
}
