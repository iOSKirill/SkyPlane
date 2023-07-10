//
//  WeatherView<odel.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 14.06.23.
//

import Foundation
import SwiftUI

final class WeatherViewModel: ObservableObject {
    
    //MARK: - Property -
    private var alamofireProvider: AlamofireProviderProtocol = AlamofireProvider()
    @Published var isPresented = false
    @Published var currentWeather: CurrentWeatherModel?
    @Published var hourlyWeather: [CurrentWeatherModel] = []
    @Published var dailyWeather: [DailyWeatherModel] = []
    @Published var nameSearchCity: String = ""
    @Published var isLoading: Bool = true
    var nameCity: String = ""
    
    //MARK: - Get weather data by city name -
    func getWeatherDataByCityName(cityName: String) {
        Task { [weak self] in
            guard let self = self else { return }
            let coordinatesByName = try await alamofireProvider.getCoordinatesByName(nameCity: cityName)
            guard let lat = coordinatesByName.first?.lat, let lon = coordinatesByName.first?.lon else {
                return print("Error city name")
            }
            let weatherDataByCoordinates = try await alamofireProvider.getWeatherForCityCoordinates(lat: lat, lon: lon)
            let mappedCurrent = CurrentWeatherModel(data: weatherDataByCoordinates.current)
            let mappedHourly = weatherDataByCoordinates.hourly
                .map { CurrentWeatherModel(data: $0) }
            let mappedDaily = weatherDataByCoordinates.daily
                .map { DailyWeatherModel(data: $0) }
            await MainActor.run {
                self.hourlyWeather = mappedHourly
                self.currentWeather = mappedCurrent
                self.dailyWeather = mappedDaily
                self.nameCity = cityName
                self.nameSearchCity = ""
                self.isLoading = false
            }
        }
    }
}
