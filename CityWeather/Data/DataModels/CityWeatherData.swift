//
//  CityWeatherData.swift
//  CityWeather
//
//  Created by Jake Sulkoske on 4/3/22.
//

import Foundation

struct HourlyWeatherData: Decodable {
    var list: [WeatherData]
}

struct WeatherData: Decodable {
    var weather: [WeatherOverview]?
    var main: Temperature?
    var wind: Wind?
    var dt_txt: String?
}

struct WeatherOverview: Decodable {
    var id: Int?
    var main: String?
    var description: String?
}

struct Temperature: Decodable {
    var temp: Double?
    var feels_like: Double?
    var temp_min: Double?
    var temp_max: Double?
}

struct Wind: Codable {
    var speed: Double?
    var deg: Int?
}
