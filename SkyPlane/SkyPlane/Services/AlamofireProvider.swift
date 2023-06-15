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
}

//MARK: - Class -
class AlamofireProvider: AlamofireProviderProtocol {
    
    //MARK: - Property -
    private let apiWeather = Bundle.main.object(forInfoDictionaryKey: "ApiWeatherKey") as? String ?? "Api Error"
    private let language = Locale.current.language.languageCode?.identifier ?? "en"
    private let units: Units = .metric
    
    //MARK: - Method -
    
    //Getting Coordinates by city name
    func getCoordinatesByName(nameCity: String) async throws -> [CoordinateModel] {
        let parameters = addParams(queryItems: ["q": nameCity,
                                                "limit": "1",
                                                "lang": language])
        return try await AF.request(Constants.getCodingURL, method: .get, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default).serializingDecodable([CoordinateModel].self).value
    }
    
    //Getting Weather by coordinates
    func getWeatherForCityCoordinates(lat: Double, lon: Double) async throws -> WeatherModel {
        let parameters = addParams(queryItems: ["lat": lat.description,
                                                "lon": lon.description,
                                                "exclude": "alerts,minutely",
                                                "units": "\(units)",
                                                "lang": language])
        return try await AF.request(Constants.weatherURL, method: .get, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default).serializingDecodable(WeatherModel.self).value
    }
    
    //Getting the weather icon
    func getImageIcon(icon: String) async throws -> Data {
        let parameters = "\(Constants.imageURL)\(icon).png"
        return try await AF.download(parameters).serializingData().value
    }
    
    //Parameters
    private func addParams(queryItems: [String: String]) -> [String: String] {
        var params: [String: String] = [:]
        params = queryItems
        params["appid"] = apiWeather
        return params
    }
}

