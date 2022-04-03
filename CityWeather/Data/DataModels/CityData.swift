//
//  CityData.swift
//  CityWeather
//
//  Created by Jake Sulkoske on 4/3/22.
//

import Foundation

public struct CityData: Decodable {
    var name: String
    var lat: Double
    var lon: Double
}
