//
//  CityWeatherDataManager.swift
//  CityWeather
//
//  Created by Jake Sulkoske on 4/3/22.
//

import Foundation

public struct CityWeatherDataManager {
    
    fileprivate let kBaseWeatherEndpoint: String = "https://api.openweathermap.org/data/2.5/"
    fileprivate let kBaseWeatherDataURL: String = "https://api.openweathermap.org/geo/1.0/direct?q="
    fileprivate let kAPIKey: String = "e1c77c38575299ac5173f878ef44ac6a"
    
    func getCityCurrentWeatherDataFromCoordinates(city: City, completion: @escaping (WeatherData?, LocalizedError?) -> Void) async {
        let kCurrentWeatherBaseURL: String = "\(kBaseWeatherEndpoint)weather?lat="
        guard let url = URL(string: "\(kCurrentWeatherBaseURL)\(city.lat)&lon=\(city.lon)&appid=\(kAPIKey)&units=imperial")
        else {
            NSLog(AppError.formatting.errorTitle ?? "")
            completion(nil, AppError.formatting)
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let data = try? JSONDecoder().decode(WeatherData.self, from: data) {
                let weatherData = WeatherData(weather: data.weather, main: data.main, wind: data.wind)
                completion(weatherData, nil)
            } else {
                NSLog(AppError.parsing.errorTitle ?? "")
                completion(nil, AppError.parsing)
            }
        } catch {
            NSLog(AppError.network.errorTitle ?? "")
            completion(nil, AppError.network)
        }
    }
    
    func getCityHourlyWeatherDataFromCoordinates(city: City, completion: @escaping (HourlyWeatherData?, LocalizedError?) -> Void) async {
        let kHourlyWeatherBaseURL: String = "\(kBaseWeatherEndpoint)forecast?lat="
        guard let url = URL(string: "\(kHourlyWeatherBaseURL)\(city.lat)&lon=\(city.lon)&appid=\(kAPIKey)&units=imperial")
        else {
            completion(nil, AppError.formatting)
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let weatherData = try? JSONDecoder().decode(HourlyWeatherData.self, from: data) {
                let weatherData =  HourlyWeatherData(list: weatherData.list)
                completion(weatherData, nil)
            } else {
                NSLog(AppError.parsing.errorTitle ?? "")
                completion(nil, AppError.parsing)
            }
        } catch {
            NSLog(AppError.network.errorTitle ?? "")
            completion(nil, AppError.network)
        }
    }

    func getCityDataFromCityNameString(cityString: String, completion: @escaping (CityData?, LocalizedError?) -> Void) async {
        
        guard let formattedCityString = cityString.formatAsURL() else {
            NSLog(AppError.formatting.errorTitle ?? "")
            completion(nil, AppError.formatting)
            return
        }
        let urlString: String = "\(kBaseWeatherDataURL)\(formattedCityString)&limit=5&appid=\(kAPIKey)"
        guard let url = URL(string: urlString) else { return }
       
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let cityData = try?
                JSONDecoder().decode([CityData].self, from: data) {
                if !cityData.isEmpty {
                    let city = cityData[0]

                    completion(city, nil)

                } else {
                    NSLog(AppError.parsing.errorTitle ?? "")
                    completion(nil, AppError.parsing)
                }
            } else {
                NSLog(AppError.network.errorTitle ?? "")
                completion(nil, AppError.network)
            }
        } catch {
            NSLog(AppError.network.errorTitle ?? "")
            completion(nil, AppError.network)
        }
    }
    
}
