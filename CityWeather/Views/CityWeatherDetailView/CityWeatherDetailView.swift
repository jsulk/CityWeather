//
//  CityWeatherDetailView.swift
//  CityWeather
//
//  Created by Jake Sulkoske on 4/3/22.
//

import SwiftUI
import Lottie

struct CityWeatherDetailView: View {
    
    private var viewModel: ViewModel
    
    public init(model: ViewModel) {
        self.viewModel = model
    }
    
    var body: some View {
        weatherDataDetailList
        
        animationView
    }
    
    @ViewBuilder
    private var weatherDataDetailList: some View {
        List {
            currentWeatherSection
            
            forecastWeatherSection
        }
        .navigationTitle(self.viewModel.cityName)
    }
    
    @ViewBuilder
    private var animationView: some View {
        LottieView(animationName: viewModel.animationName,
                           loopMode: .loop,
                           contentMode: .scaleAspectFit)
        .frame(height: viewModel.kAnimationHeight)
    }
    
    @ViewBuilder
    private var currentWeatherSection: some View {
        Section(header: Text(viewModel.kCurrentWeather)) {
            Text(viewModel.currentTemp)
            Text(viewModel.currentFeelsLike)
            Text(viewModel.currentLowHigh)
            Text(viewModel.currentWind)
        }
    }
    
    @ViewBuilder
    private var forecastWeatherSection: some View {
        Section(header: Text(viewModel.hourlyHeader)) {
            Text(viewModel.hourlyTemp)
            Text(viewModel.hourlyFeelsLike)
            Text(viewModel.hourlyWind)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        CityWeatherDetailView(model: CityWeatherDetailView.ViewModel(cityCurrentData: CityCurrentData(cityName: "Los Angeles", currentData: WeatherData(weather: [WeatherOverview(id: 0, main: "Rainy", description: "You're going to need an umbrella")], main: Temperature(temp: 0.0, feels_like: 0.0, temp_min: 0.0, temp_max: 0.0), wind: Wind(speed: 0.0, deg: 21))), cityHourlyData: CityHourlyData(cityName: "Los Angeles", hourlyData: HourlyWeatherData(list: [WeatherData(weather: [WeatherOverview(id: 0, main: "Rainy", description: "You're going to need an umbrella")], main: Temperature(temp: 0.0, feels_like: 0.0, temp_min: 0.0, temp_max: 0.0), wind: Wind(speed: 0.0, deg: 21))]))))
    }
}
