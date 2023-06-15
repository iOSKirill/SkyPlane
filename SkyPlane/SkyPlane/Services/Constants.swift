//
//  Constants.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 14.06.23.
//

import Foundation

struct Constants {

    //MARK: - OpenWeatherApi -
    static var baseURL = "https://api.openweathermap.org/"
    
    static var getCodingURL: String {
        return baseURL.appending("geo/1.0/direct?")
    }
    
    static var weatherURL: String {
        return baseURL.appending("data/2.5/onecall?")
    }
    
    static let imageURL = "https://openweathermap.org/img/wn/"
}
