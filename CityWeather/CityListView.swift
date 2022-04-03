//
//  CityListView.swift
//  CityWeather
//
//  Created by Jake Sulkoske on 4/2/22.
//

import SwiftUI

struct CityListView: View {
    
    @Environment(\.managedObjectContext) var context
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var storedCities: FetchedResults<City>
    @State private var showingDetail = false
    
    private var kNoCities: String = "You don't have any cities saved, yet. Try adding one by tapping the Add City button!"
    private var kSavedCities: String = "Saved Cities"
    private var kAddCity: String = "Add City"
    
    var body: some View {
        cityList
    }
    
    @ViewBuilder
    private var cityList: some View {
        VStack {
            savedCitiesListView
        }
        .navigationTitle(kSavedCities)
        .toolbar {
            self.addCityNavButton
        }
    }
    
    @ViewBuilder
    private var savedCitiesListView: some View {
        if !storedCities.isEmpty {
            List {
                ForEach(storedCities) { city in
                    if let cityName = city.name {
                        Text(cityName)
                    }
                }
            }
        } else {
            Text(kNoCities)
        }
    }
    
    @ViewBuilder
    private var addCityNavButton: some View {
        Button(kAddCity) {
            showingDetail = true
        }
        .sheet(isPresented: $showingDetail) {
            AddCityView()
        }
    }
}

struct CitiesListView_Previews: PreviewProvider {
    static var previews: some View {
        CityListView()
    }
}
