//
//  DateFormatterExtensions.swift
//  CityWeather
//
//  Created by Jake Sulkoske on 4/3/22.
//

import Foundation

extension DateFormatter {
    
    public static let shortStyleTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateFormat = "yyyy-mm-dd HH:mm:ss"
        return formatter
    }()
    
    public static let convertDateToString: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
    
    public static func convertDateTimeToString(dateString: String) -> String? {
        if let formattedDate = DateFormatter.shortStyleTime.date(from: dateString) {
            return DateFormatter.convertDateToString.string(from: formattedDate)
        } else {
            return nil
        }
    }
}
