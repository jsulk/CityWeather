//
//  AddCityView.swift
//  CityWeather
//
//  Created by Jake Sulkoske on 4/2/22.
//

import SwiftUI

struct AddCityView: View {
    
    @Environment(\.managedObjectContext) var context
    @Environment(\.presentationMode) var presentationMode
    
    @State private var searchResults: [String]?
    @State private var input: String = ""
    
    private let dataManager = CityWeatherDataManager()
    private let googlePlaceDataManager = GooglePlacesDataManager()
    
    public init() {}
    
    var body: some View {
        NavigationView {
            VStack {
                searchableListView
            }
        }
    }
    
    @ViewBuilder
    private var searchableListView: some View {
        List {
            if let results = searchResults {
                ForEach(results, id: \.self) { result in
                    Button(result) {
                        Task.init {
                            await self.getCityDataForSelectedCityString(result)
                        }
                    }
                    .foregroundColor(Color.black)
                }
            }
        }
        .searchable(text: $input)
        .onChange(of: input, perform: { value in
            Task.init(operation: {
                await self.updateSearchResults(value: value)
            })
        })
    }
    
    private func updateSearchResults(value: String) async {
        if !value.isEmpty {
            self.searchResults = []
            self.searchResults = await googlePlaceDataManager.getSearchResults(input: input)
        } else {
            searchResults = []
        }
    }
    
    private func getCityDataForSelectedCityString(_ result:String) async {
        await dataManager.getCityData(cityString:result, completion: { city in
            self.addCityToAppStorage(city: city)
            presentationMode.wrappedValue.dismiss()
        })
    }
    
    private func addCityToAppStorage(city: CityData?) {
        if let city = city {
            let newCity = City(context: context)
            newCity.id = UUID()
            newCity.name = city.name
            newCity.lat = city.lat
            newCity.lon = city.lon

            try? context.save()
        }
    }
}

struct AddCityView_Previews: PreviewProvider {
    static var previews: some View {
        AddCityView()
    }
}
