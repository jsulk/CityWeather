//
//  AddCityView.swift
//  CityWeather
//
//  Created by Jake Sulkoske on 4/2/22.
//

import SwiftUI

struct AddCityView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel = ViewModel()
    
    public init() {}
    
    var body: some View {
        NavigationView {
            VStack {
                searchableListView
            }
            .alert(isPresented: viewModel.isPresentingAlert, content: {
                Alert(localizedError: viewModel.activeError!)
            })
        }
    }
    
    @ViewBuilder
    private var searchableListView: some View {
        List {
            if let results = viewModel.searchResults {
                ForEach(results, id: \.self) { result in
                    Button(result) {
                        Task.init {
                            await viewModel.getCityDataForSelectedCityString(result, completion: {
                                DispatchQueue.main.async {
                                    presentationMode.wrappedValue.dismiss()
                                }
                            })
                        }
                    }
                    .foregroundColor(Color.black)
                }
            }
        }
        .searchable(text: $viewModel.input)
        .onChange(of: viewModel.input, perform: { input in
            Task.init(operation: {
                await viewModel.updateSearchResults(value: input)
            })
        })
    }
}

struct AddCityView_Previews: PreviewProvider {
    static var previews: some View {
        AddCityView()
    }
}
