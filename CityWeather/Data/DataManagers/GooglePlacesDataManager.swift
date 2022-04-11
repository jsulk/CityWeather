//
//  GooglePlacesDataManager.swift
//  CityWeather
//
//  Created by Jake Sulkoske on 4/3/22.
//

import Foundation
import Combine

struct GooglePlacesDataManager {
    
    fileprivate let kGooglePlaceBaseURL: String = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input="
    fileprivate let kTypesQuery: String = "&types=geocode&key="
    fileprivate let kAPIKey: String = "AIzaSyDG4M12mjJTHkZgbCIZuBxEIwNPAYoaGKE"
    
    private let decoder = Decoder()
    
    func getSearchResults(input: String) -> AnyPublisher<SearchResults, Error> {
        guard let formattedInput = input.formatAsURL(),
              let url = URL(string: "\(kGooglePlaceBaseURL)\(formattedInput)\(kTypesQuery)\(kAPIKey)")
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
}
