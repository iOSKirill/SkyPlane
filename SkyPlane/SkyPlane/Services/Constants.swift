//
//  Constants.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 14.06.23.
//

import Foundation

struct Constants {

    //MARK: - OpenWeatherApi -
    static var baseURLWeather = "https://api.openweathermap.org/"
    
    static var getCodingURL: String {
        return baseURLWeather.appending("geo/1.0/direct?")
    }
    
    static var weatherURL: String {
        return baseURLWeather.appending("data/2.5/onecall?")
    }
    
    static let imageURL = "https://openweathermap.org/img/wn/"
    
    //MARK: - AviasalesApi
    static var baseURLAviasales = "https://api.travelpayouts.com/"
    static var autocompleteURL = "https://autocomplete.travelpayouts.com/places2"
    
    static var getFlightsInfo: String {
        return baseURLAviasales.appending("aviasales/v3/prices_for_dates?")
    }
    
    static var getPopularFlightsByCityName: String {
        return baseURLAviasales.appending("v1/city-directions?")
    }
    
    static var getIconAirline = "https://pics.avs.io/120/35/"
}
