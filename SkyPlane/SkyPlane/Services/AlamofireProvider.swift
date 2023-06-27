//
//  AlamofireProvider.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 14.06.23.
//

import Foundation
import Alamofire

//MARK: - Units weather -
enum Units: String {
    case standard = "Стандарт"
    case metric = "Метрический"
    case imperial = "Имперский"
}

enum ApiType {
    case apiWeather
    case apiAviasales
    
    var apiKey: String? {
        switch self {
        case .apiWeather:
            return Bundle.main.object(forInfoDictionaryKey: "ApiWeatherKey") as? String
        case .apiAviasales:
            return Bundle.main.object(forInfoDictionaryKey: "ApiAviasalesKey") as? String
        }
    }
}

//MARK: - Protocol -
protocol AlamofireProviderProtocol {
    func getCoordinatesByName(nameCity: String) async throws -> [CoordinateModel]
    func getWeatherForCityCoordinates(lat: Double, lon: Double) async throws -> WeatherModel
    func getFlightsInfo(origin: String, destination: String, departureDate: String, returnDate: String) async throws -> FlightInfo
    func getPopularFlightsByCityName(cityName: String) async throws -> PopularFlight
    func getCodeByCityName(cityName: String) async throws -> [Autocomplete]
}

//MARK: - Class -
class AlamofireProvider: AlamofireProviderProtocol {
    
    //MARK: - Property -
    private let language = Locale.current.language.languageCode?.identifier ?? "en"
    private let currency = Locale.current.currency?.identifier ?? "usd"
    private let units: Units = .metric
    
    //MARK: - Method -
    
    //Generic request
    private func makeRequest<T: Decodable>(url: String, parameters: [String: String], encoding: ParameterEncoder = URLEncodedFormParameterEncoder.default) async throws -> T {
        return try await AF.request(url, method: .get, parameters: parameters, encoder: encoding).serializingDecodable(T.self).value
    }

    //Getting Coordinates by city name
    func getCoordinatesByName(nameCity: String) async throws -> [CoordinateModel] {
        let parameters = addParams(apiType: .apiWeather, queryItems: ["q": nameCity,
                                                       "limit" : "1",
                                                       "lang" : language])
        return try await makeRequest(url: Constants.getCodingURL, parameters: parameters)
    }
    
    //Getting Weather by coordinates
    func getWeatherForCityCoordinates(lat: Double, lon: Double) async throws -> WeatherModel {
        let parameters = addParams(apiType: .apiWeather, queryItems: ["lat" : lat.description,
                                                       "lon" : lon.description,
                                                       "exclude" : "alerts,minutely",
                                                       "units" : "\(units)",
                                                       "lang" : language])
        return try await makeRequest(url: Constants.weatherURL, parameters: parameters)
    }
    
    //Getting all info from ticket
    func getFlightsInfo(origin: String, destination: String, departureDate: String, returnDate: String) async throws -> FlightInfo {
        let parameters = addParams(apiType: .apiAviasales, queryItems: ["origin" : origin,
                                                         "destination" : destination,
                                                         "departure_at" : departureDate,
                                                         "return_at" : returnDate,
                                                         "currency" : currency,
                                                         "sorting" : "price",
                                                         "direct" : "false",
                                                         "limit" : "1000"])
        return try await makeRequest(url: Constants.getFlightsInfo, parameters: parameters)
    }
    
    //Getting popular flight by city name
    func getPopularFlightsByCityName(cityName: String) async throws -> PopularFlight {
        let parameters = addParams(apiType: .apiAviasales, queryItems: ["origin": cityName,
                                                         "currency" : currency,
                                                         "limit" : "10"])
        return try await makeRequest(url: Constants.getPopularFlightsByCityName, parameters: parameters)
    }
    
    //Getting code by city name
    func getCodeByCityName(cityName: String) async throws -> [Autocomplete] {
        let parameters = addParams(apiType: .apiAviasales, queryItems: ["locale" : language,
                                                                        "types[]" : "city" ,
                                                                        "term" : cityName])
        return try await makeRequest(url: Constants.autocompleteURL, parameters: parameters)
    }
    
    //Parameters
    private func addParams(apiType: ApiType, queryItems: [String: String]) -> [String: String] {
        var params: [String: String] = queryItems
        if let apiKey = apiType.apiKey {
            switch apiType {
            case .apiWeather:
                params["appid"] = apiKey
            case .apiAviasales:
                params["token"] = apiKey
            }
        }
        return params
    }


}

