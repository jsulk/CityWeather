//
//  CityWeatherListView.swift
//  CityWeather
//
//  Created by Jake Sulkoske on 4/2/22.
//

import SwiftUI

import SwiftUI

struct CitiesWeatherListView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                citiesListView
            }
            .navigationTitle("Forecasts")
            .toolbar {
                self.navigationButton
            }
        }
    }
    
    @ViewBuilder
    private var citiesListView: some View {
        List {
            Text("City 1")
            Text("City 2")
        }
    }
    
    @ViewBuilder
    var navigationButton: some View {
        NavigationLink(destination: CityListView()) {
            Text("Cities")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CitiesWeatherListView()
    }
}
