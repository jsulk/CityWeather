//
//  GooglePlacesDataManager.swift
//  CityWeather
//
//  Created by Jake Sulkoske on 4/3/22.
//

import Foundation

struct GooglePlacesDataManager {
    
    fileprivate let kGooglePlaceBaseURL: String = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input="
    fileprivate let kSecondHalf: String = "&types=geocode&key=AIzaSyDG4M12mjJTHkZgbCIZuBxEIwNPAYoaGKE"
    
    public func getSearchResults(input: String) async -> [String]? {
        if !input.isEmpty {
            let formattedInput = input.replacingOccurrences(of: " ", with: "%20")
            guard let url = URL(string: "\(kGooglePlaceBaseURL)\(formattedInput)\(kSecondHalf)") else { return nil }
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let results = try? JSONDecoder().decode(SearchResults.self, from: data) {
                    var searchResults = [String]()
                    for result in results.predictions {
                        searchResults.append(result.structured_formatting.main_text)
                    }
                    return searchResults
                } else {
                    //Couldn't parse response
                    print("FAILED")
                }
            } catch {
                print("INVALID DATA")
            }
        }
        return nil
    }
}
