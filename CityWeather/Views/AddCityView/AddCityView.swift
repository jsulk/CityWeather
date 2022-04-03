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
    
    @StateObject var viewModel = ViewModel()
    
    private let dataManager = CityWeatherDataManager()
    
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
            if let results = viewModel.searchResults {
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
        .searchable(text: $viewModel.input)
        .onChange(of: viewModel.input, perform: { value in
            Task.init(operation: {
                await viewModel.updateSearchResults(value: value)
            })
        })
    }
    
    private func getCityDataForSelectedCityString(_ result:String) async {
        await dataManager.getCityData(cityString:result, completion: { city in
            self.addCityToAppStorage(city: city)
            DispatchQueue.main.async {
                presentationMode.wrappedValue.dismiss()
            }
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
