//
//  GooglePlacesDataManager.swift
//  CityWeather
//
//  Created by Jake Sulkoske on 4/3/22.
//

import Foundation

struct GooglePlacesDataManager {
    
    fileprivate let kGooglePlaceBaseURL: String = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input="
    fileprivate let kTypesQuery: String = "&types=geocode&key="
    fileprivate let kAPIKey: String = "AIzaSyDG4M12mjJTHkZgbCIZuBxEIwNPAYoaGKE"
    
    public func getSearchResults(input: String, completion: @escaping ([String]?, LocalizedError?) -> Void) async  {
        if !input.isEmpty {
            
            guard let formattedInput = input.formatAsURL(),
                  let url = URL(string: "\(kGooglePlaceBaseURL)\(formattedInput)\(kTypesQuery)\(kAPIKey)")
            else {
                NSLog(AppError.formatting.errorTitle ?? "")
                completion(nil, AppError.formatting)
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let results = try? JSONDecoder().decode(SearchResults.self, from: data) {
                    var searchResults = [String]()
                    for result in results.predictions {
                        searchResults.append(result.structured_formatting.main_text)
                    }
                    return completion(searchResults, nil)
                } else {
                    NSLog(AppError.parsing.errorTitle ?? "")
                    completion(nil, AppError.parsing)
                }
            } catch {
                NSLog(AppError.network.errorTitle ?? "")
                completion(nil, AppError.network)
            }
        }
        NSLog(AppError.network.errorTitle ?? "")
        completion(nil, AppError.network)
    }
}
