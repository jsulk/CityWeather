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
        List(storedCities) { city in
            if let cityName = city.name {
                Text(cityName)
            }
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
