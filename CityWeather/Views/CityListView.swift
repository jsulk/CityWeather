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
    
    private var kNoCities: String = "Add a city by tapping the Add City button!"
    private var kSavedCities: String = "Saved Cities"
    private var kAddCity: String = "Add City"
    private var kHorizontalPadding: CGFloat = 16
    
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
                .onDelete(perform: deleteCityFromStorage)
            }
        } else {
            Text(kNoCities)
                .padding(.horizontal, kHorizontalPadding)
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
    
    private func deleteCityFromStorage(at offsets: IndexSet) {
        for offset in offsets {
            let city = storedCities[offset]
            context.delete(city)
        }
        try? context.save()
    }
}

struct CitiesListView_Previews: PreviewProvider {
    static var previews: some View {
        CityListView()
    }
}
