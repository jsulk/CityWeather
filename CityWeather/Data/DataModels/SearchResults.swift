//
//  SearchResults.swift
//  CityWeather
//
//  Created by Jake Sulkoske on 4/3/22.
//

import Foundation

struct SearchResults: Decodable {
    var predictions: [Prediction]
}

struct Prediction: Decodable {
    var description: String
    var structured_formatting: SearchPrediction
}

struct SearchPrediction: Decodable {
    var main_text: String
}
