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

//MARK: - Protocol -
protocol AlamofireProviderProtocol {
    func getCoordinatesByName(nameCity: String) async throws -> [CoordinateModel]
    func getWeatherForCityCoordinates(lat: Double, lon: Double) async throws -> WeatherModel
    func getImageIcon(icon: String) async throws -> Data
    func getFlightsInfo(origin: String, destination: String, departureDate: String, returnDate: String) async throws -> FlightInfo
    func getPopularFlightsByCityName(cityName: String) async throws -> PopularFlight
}

//MARK: - Class -
class AlamofireProvider: AlamofireProviderProtocol {
    
    //MARK: - Property -
    private let apiWeather = Bundle.main.object(forInfoDictionaryKey: "ApiWeatherKey") as? String ?? "Api Weather Error"
    private let apiAviasales = Bundle.main.object(forInfoDictionaryKey: "ApiAviasalesKey") as? String ?? "Api Aviasales Error"
    private let language = Locale.current.language.languageCode?.identifier ?? "en"
    private let units: Units = .metric
    
    //MARK: - Method -
    
    //Getting Coordinates by city name
    func getCoordinatesByName(nameCity: String) async throws -> [CoordinateModel] {
        let parameters = addParamsWeather(queryItems: ["q": nameCity,
                                                       "limit" : "1",
                                                       "lang" : language])
        return try await AF.request(Constants.getCodingURL, method: .get, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default).serializingDecodable([CoordinateModel].self).value
    }
    
    //Getting Weather by coordinates
    func getWeatherForCityCoordinates(lat: Double, lon: Double) async throws -> WeatherModel {
        let parameters = addParamsWeather(queryItems: ["lat" : lat.description,
                                                       "lon" : lon.description,
                                                       "exclude" : "alerts,minutely",
                                                       "units" : "\(units)",
                                                       "lang" : language])
        return try await AF.request(Constants.weatherURL, method: .get, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default).serializingDecodable(WeatherModel.self).value
    }
    
    //Getting the weather icon
    func getImageIcon(icon: String) async throws -> Data {
        let parameters = "\(Constants.imageURL)\(icon).png"
        return try await AF.download(parameters).serializingData().value
    }
    
    //Getting all info from ticket
    func getFlightsInfo(origin: String, destination: String, departureDate: String, returnDate: String) async throws -> FlightInfo {
        let parameters = addParamsAviasales(queryItems: ["origin" : origin,
                                                         "destination" : destination,
                                                         "departure_at" : departureDate,
                                                         "return_at" : returnDate,
                                                         "currency" : "usd",
                                                         "sorting" : "price",
                                                         "direct" : "false",
                                                         "limit" : "1000"])
        return try await AF.request(Constants.getFlightsInfo, method: .get, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default).serializingDecodable(FlightInfo.self).value
    }
    
    //Getting popular flight by city name
    func getPopularFlightsByCityName(cityName: String) async throws -> PopularFlight {
        let parameters = addParamsAviasales(queryItems: ["origin": cityName,
                                                         "currency" : "usd",
                                                         "limit" : "10"])
        return try await AF.request(Constants.getPopularFlightsByCityName, method: .get, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default).serializingDecodable(PopularFlight.self).value
    }
    
    //Parameters Weather
    private func addParamsWeather(queryItems: [String: String]) -> [String: String] {
        var params: [String: String] = [:]
        params = queryItems
        params["appid"] = apiWeather
        return params
    }
    
    //Parameters Aviasales
    private func addParamsAviasales(queryItems: [String: String]) -> [String: String] {
        var params: [String: String] = [:]
        params = queryItems
        params["token"] = apiAviasales
        return params
    }
}

