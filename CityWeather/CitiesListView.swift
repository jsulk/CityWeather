//
//  CitiesListView.swift
//  CityWeather
//
//  Created by Jake Sulkoske on 4/2/22.
//

import SwiftUI

struct CitiesListView: View {
    
    @State private var showingDetail = false
    
    var body: some View {
        VStack {
            savedCitiesListView
        }
        .navigationTitle("Saved Cities")
        .toolbar {
            self.addCityNavButton
        }
    }
    
    @ViewBuilder
    private var savedCitiesListView: some View {
        List {
            Text("City 1")
            Text("City 2")
        }
    }
    
    @ViewBuilder
    private var addCityNavButton: some View {
        Button("Add City") {
            showingDetail = true
        }
        .sheet(isPresented: $showingDetail) {
            AddCityView()
        }
    }
}

struct CitiesListView_Previews: PreviewProvider {
    static var previews: some View {
        CitiesListView()
    }
}
