//
//  CityWeatherDetailView.swift
//  CityWeather
//
//  Created by Jake Sulkoske on 4/3/22.
//

import SwiftUI

struct CityWeatherDetailView: View {
    
    private var viewModel: ViewModel
    
    public init(model: ViewModel) {
        self.viewModel = model
    }
    
    var body: some View {
        weatherDataDetailList
    }
    
    @ViewBuilder
    private var weatherDataDetailList: some View {
        if let currentWeather = self.viewModel.cityCurrentData.currentData.main
        {
            List {
                Text("Current Temp: \(Int(currentWeather.temp ?? 0))°")
                Text("Feels Like: \(Int(currentWeather.feels_like ?? 0))°")
                Text("Low/High: \(Int(currentWeather.temp_min ?? 0))°-\(Int(currentWeather.temp_max ?? 0))°")
            }
            .navigationTitle(self.viewModel.cityName)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        CityWeatherDetailView(model: CityWeatherDetailView.ViewModel(cityCurrentData: CityCurrentData(cityName: "Los Angeles", currentData: WeatherData(weather: [WeatherOverview(id: 0, main: "Rainy", description: "You're going to need an umbrella")], main: Temperature(temp: 0.0, feels_like: 0.0, temp_min: 0.0, temp_max: 0.0), wind: Wind(speed: 0.0, deg: 21))), cityHourlyData: CityHourlyData(cityName: "Los Angeles", hourlyData: HourlyWeatherData(list: [WeatherData(weather: [WeatherOverview(id: 0, main: "Rainy", description: "You're going to need an umbrella")], main: Temperature(temp: 0.0, feels_like: 0.0, temp_min: 0.0, temp_max: 0.0), wind: Wind(speed: 0.0, deg: 21))]))))
    }
}
