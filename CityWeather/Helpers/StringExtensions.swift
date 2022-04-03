//
//  StringExtensions.swift
//  CityWeather
//
//  Created by Jake Sulkoske on 4/3/22.
//

import Foundation

extension String {
    public func formatAsURL() -> String? {
        let formattedString = self.replacingOccurrences(of: " ", with: "%20")
        return formattedString.isEmpty ? nil : formattedString
    }
}
