//
//  CityWeatherListView.swift
//  CityWeather
//
//  Created by Jake Sulkoske on 4/2/22.
//

import SwiftUI

struct CityWeatherListView: View {
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var storedCities: FetchedResults<City>
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                citiesListView
                
                segmentedTab
            }
            .navigationTitle(viewModel.navTitle)
            .onAppear {
                Task.init {
                    await viewModel.fetchData(storedCities: storedCities)
                }
            }
            .toolbar {
                self.navigationButton
            }
            .alert(isPresented: viewModel.isPresentingAlert, content: {
                Alert(localizedError: viewModel.activeError!)
            })
        }
        .accentColor(AppConstants.Colors.accentColor)
    }
    
    @ViewBuilder
    private var citiesListView: some View {
        List(storedCities) { city in
            if let cityId =  city.id,
               let currentCityData = viewModel.currentCityWeatherData[cityId],
               let hourlyCityData = viewModel.hourlyCityWeatherData[cityId] {
                if viewModel.isShowingCurrentForecast {
                    CurrentForecastRow(model: CurrentForecastRow.ViewModel(cityCurrentData: currentCityData, cityHourlyData: hourlyCityData))
                } else {
                    HourlyForecastRow(model: HourlyForecastRow.ViewModel(cityCurrentData: currentCityData, cityHourlyData: hourlyCityData))
                }
            }
        }
        .overlay(Group {
            listViewOverlay
        })
        .refreshable {
            await viewModel.fetchData(storedCities: storedCities, shouldForce: true)
        }
    }
    
    @ViewBuilder
    private var listViewOverlay: some View {
        if storedCities.isEmpty {
            Text(viewModel.kNoSavedCitiesText)
        }
    }
    
    @ViewBuilder
    private var segmentedTab: some View {
        VStack {
            Picker("Current/Hourly", selection: $viewModel.isShowingCurrentForecast) {
                Text(viewModel.kCurrent).tag(true)
                Text(viewModel.kHourly).tag(false)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, viewModel.kTabHorizontalPadding)
            .padding(.vertical, viewModel.kTabBottomPadding)
        }
        .background(AppConstants.Colors.accentColor)
    }
    
    @ViewBuilder
    private var navigationButton: some View {
        NavigationLink(destination: CityListView()) {
            Text(viewModel.kCities)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CityWeatherListView()
    }
}
