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
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            savedCitiesListView
        }
        .navigationTitle(viewModel.kSavedCities)
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
            Text(viewModel.kNoCities)
                .padding(.horizontal, viewModel.kHorizontalPadding)
        }
    }
    
    @ViewBuilder
    private var addCityNavButton: some View {
        Button(viewModel.kAddCity) {
            viewModel.showingDetail = true
        }
        .sheet(isPresented: $viewModel.showingDetail) {
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
