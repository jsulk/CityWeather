//
//  Decoder.swift
//  CityWeather
//
//  Created by Jake Sulkoske on 4/10/22.
//

import Foundation
import Combine

struct Decoder {
    func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, Error> {
      return Just(data)
            .decode(type: T.self, decoder: JSONDecoder())
        .mapError { _ in  URLError(.badServerResponse) }
        .eraseToAnyPublisher()
    }
}
