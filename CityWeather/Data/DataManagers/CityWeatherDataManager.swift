//
//  CityWeatherDataManager.swift
//  CityWeather
//
//  Created by Jake Sulkoske on 4/3/22.
//

import Foundation

public struct CityWeatherDataManager {
    
    private let kBaseWeatherDataURL: String = "https://api.openweathermap.org/geo/1.0/direct?q="
    private let kWeatherDataAppId: String = "e1c77c38575299ac5173f878ef44ac6a"

    func getCityData(cityString: String, completion: @escaping (CityData?) -> Void) async {
        
        guard let formattedCityString = cityString.formatAsURL() else {
            completion(nil)
            return
        }
        let urlString: String = "\(kBaseWeatherDataURL)\(formattedCityString)&limit=5&appid=\(kWeatherDataAppId)"
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
