//
//  CityWeatherListView.swift
//  CityWeather
//
//  Created by Jake Sulkoske on 4/2/22.
//

import SwiftUI

struct CitiesWeatherListView: View {
    
    @Environment(\.managedObjectContext) var context
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var storedCities: FetchedResults<City>
    
    @State private var isShowingCurrentForecast: Bool = true
    @State private var currentCityWeatherData: [UUID:CityCurrentData] = [:]
    @State private var hourlyCityWeatherData: [UUID:CityHourlyData] = [:]
    
    private let dataManager = CityWeatherDataManager()
    
    private let kCurrent = "Current"
    private let kHourly = "Hourly"
    private let kForecasts = "Forecasts"
    private let kCities = "Cities"
    private let kNoSavedCitiesText = "You don't have any cities saved, yet!"
    private let kTabHorizontalPadding: CGFloat = 40
    private let kTabBottomPadding: CGFloat = 16
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                citiesListView
                
                segmentedTab
            }
            .navigationTitle(navTitle)
            .toolbar {
                self.navigationButton
            }
        }
        .accentColor(AppConstants.Colors.accentColor)
        .onAppear {
            Task.init {
                await fetchData()
            }
        }
    }
    
    @ViewBuilder
    private var citiesListView: some View {
        List(storedCities) { city in
            if let cityId =  city.id,
               let currentCityData = currentCityWeatherData[cityId],
               let hourlyCityData = hourlyCityWeatherData[cityId] {
                if isShowingCurrentForecast {
                    CurrentForecastRow(model: CurrentForecastRowModel(cityCurrentData: currentCityData, cityHourlyData: hourlyCityData))
                } else {
                    HourlyForecastRow(model: HourlyForecastRowModel(cityCurrentData: currentCityData, cityHourlyData: hourlyCityData))
                }
            }
        }
        .background(Text("Empty"))
        .refreshable {
            await self.fetchData()
        }
    }
    
    @ViewBuilder
    private var segmentedTab: some View {
        VStack {
            Picker("Current/Hourly", selection: $isShowingCurrentForecast) {
                Text(kCurrent).tag(true)
                Text(kHourly).tag(false)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, kTabHorizontalPadding)
            .padding(.vertical, kTabBottomPadding)
        }
        .background(AppConstants.Colors.accentColor)
    }
    
    @ViewBuilder
    private var navigationButton: some View {
        NavigationLink(destination: CityListView()) {
            Text(kCities)
        }
    }
    
    private var navTitle: String {
        if isShowingCurrentForecast {
            return kCurrent
        } else {
            return kForecasts
        }
    }
    
    private func fetchData() async {
        for city in storedCities {
            if let cityId = city.id {
                currentCityWeatherData[cityId] = await dataManager.getCityCurrentWeatherData(city: city)
                hourlyCityWeatherData[cityId] = await dataManager.getCityHourlyWeatherData(city: city)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CitiesWeatherListView()
    }
}
