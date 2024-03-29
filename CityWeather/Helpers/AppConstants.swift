//
//  AppConstants.swift
//  CityWeather
//
//  Created by Jake Sulkoske on 4/3/22.
//

import Foundation
import SwiftUI

public struct AppConstants {
    public struct Colors {
        public static let accentColor: Color = Color(red: 139/255, green: 194/255, blue: 133/255)
    }
    
    public static let kDegreeSymbol: String = "°F"
    public static let kMPH: String = "mph"
    
    public static let kInternalError: String = "Internal Error"
    public static let kPleaseTryAgainLater: String = "Please try again later"
    public static let kNetworkError: String = "Network Error"
    
    public static let rowHeight: CGFloat = 40
}
