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
    
    public func getCityCurrentWeatherDataFromCoordinates(city: City) async -> CityCurrentData? {
        let kCurrentWeatherBaseURL: String = "\(kBaseWeatherEndpoint)weather?lat="
        guard let url = URL(string: "\(kCurrentWeatherBaseURL)\(city.lat)&lon=\(city.lon)&appid=\(kAPIKey)&units=imperial") else { return nil }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let weatherData = try? JSONDecoder().decode(WeatherData.self, from: data) {
                if let cityName = city.name {
                    let weatherData = CityCurrentData(cityName: cityName, currentData: WeatherData(weather: weatherData.weather, main: weatherData.main, wind: weatherData.wind))
                    return weatherData
                }
            } else {
                //Couldn't parse response
                print("FAILED")
            }
        } catch {
            print("INVALID DATA")
        }
        return nil
    }
    
    public func getCityHourlyWeatherDataFromCoordinates(city: City) async -> CityHourlyData? {
        let kHourlyWeatherBaseURL: String = "\(kBaseWeatherEndpoint)forecast?lat="
        guard let url = URL(string: "\(kHourlyWeatherBaseURL)\(city.lat)&lon=\(city.lon)&appid=\(kAPIKey)&units=imperial") else { return nil }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let weatherData = try? JSONDecoder().decode(HourlyWeatherData.self, from: data) {
                if let cityName = city.name {
                    let weatherData = CityHourlyData(cityName: cityName, hourlyData: HourlyWeatherData(list: weatherData.list))
                    return weatherData
                }
            } else {
                //Couldn't parse response
                print("HERE")
            }
        } catch {
            print("INVALID DATA")
        }
        
        return nil
    }

    func getCityDataFromCityNameString(cityString: String, completion: @escaping (CityData?) -> Void) async {
        
        guard let formattedCityString = cityString.formatAsURL() else {
            completion(nil)
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

                    completion(city)

                } else {
                    completion(nil)
                    //handle no results
                }
            } else {
                //Couldn't parse response
                completion(nil)
                print("FAILED")
            }
        } catch {
            completion(nil)
            print("INVALID DATA")
        }
    }
    
}
