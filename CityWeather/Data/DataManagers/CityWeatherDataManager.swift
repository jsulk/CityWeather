//
//  CityWeatherDataManager.swift
//  CityWeather
//
//  Created by Jake Sulkoske on 4/3/22.
//

import Foundation
import Combine

public class CityWeatherDataManager {
    
    fileprivate let kBaseWeatherEndpoint: String = "https://api.openweathermap.org/data/2.5/"
    fileprivate let kBaseWeatherDataURL: String = "https://api.openweathermap.org/geo/1.0/direct?q="
    fileprivate let kAPIKey: String = "e1c77c38575299ac5173f878ef44ac6a"
    
    private let decoder = Decoder()
    
    func getCityCurrentWeatherDataFromCoordinates(city: City) -> AnyPublisher<WeatherData, Error> {
        let kCurrentWeatherBaseURL: String = "\(kBaseWeatherEndpoint)weather?lat="
        guard let url = URL(string: "\(kCurrentWeatherBaseURL)\(city.lat)&lon=\(city.lon)&appid=\(kAPIKey)&units=imperial") else {
            return Fail(error: AppConstants.badURLError).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: URLRequest(url: url))
            .mapError { error in
                error
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                self.decoder.decode(pair.data)
            }
            .eraseToAnyPublisher()
    }
    
    func getCityHourlyWeatherDataFromCoordinates(city: City) -> AnyPublisher<HourlyWeatherData, Error> {
        let kHourlyWeatherBaseURL: String = "\(kBaseWeatherEndpoint)forecast?lat="
        guard let url = URL(string: "\(kHourlyWeatherBaseURL)\(city.lat)&lon=\(city.lon)&appid=\(kAPIKey)&units=imperial")
        else {
            return Fail(error: AppConstants.badURLError).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: URLRequest(url: url))
            .mapError { error in
                error
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                self.decoder.decode(pair.data)
            }
            .eraseToAnyPublisher()
    }
    
    func getCityDataFromCityNameString(cityString: String) -> AnyPublisher<[CityData], Error> {
        
        guard let formattedCityString = cityString.formatAsURL(),
              let url = URL(string: "\(kBaseWeatherDataURL)\(formattedCityString)&limit=5&appid=\(kAPIKey)") else {
            return Fail(error: AppConstants.badURLError).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: URLRequest(url: url))
            .mapError { error in
                error
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                self.decoder.decode(pair.data)
            }
            .eraseToAnyPublisher()
    }
}
