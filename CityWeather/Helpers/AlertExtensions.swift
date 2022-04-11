//
//  AlertExtensions.swift
//  CityWeather
//
//  Created by Jake Sulkoske on 4/4/22.
//

import SwiftUI

enum AppError: LocalizedError {
    case formatting, network, parsing, internalApp
    
    var errorTitle: String? {
        switch self {
        case .formatting, .parsing, .internalApp:
            return AppConstants.kInternalError
        case .network:
            return AppConstants.kNetworkError
        }
    }
    
    var errorDescription: String? {
        switch self {
        case .formatting, .network, .parsing, .internalApp:
            return AppConstants.kPleaseTryAgainLater
        }
    }
}

extension Alert {
    init(localizedError: LocalizedError) {
        self = Alert(nsError: localizedError as NSError)
    }
     
    init(nsError: NSError) {
        let message: Text? = {
            let message = [nsError.localizedFailureReason, nsError.localizedRecoverySuggestion].compactMap({ $0 }).joined(separator: "\n\n")
            return message.isEmpty ? nil : Text(message)
        }()
        self = Alert(title: Text(nsError.localizedDescription),
                     message: message,
                     dismissButton: .default(Text("OK")))
    }
}
