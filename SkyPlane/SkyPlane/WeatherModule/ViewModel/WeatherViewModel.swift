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
    
    //MARK: - Get weather data by city name -
    func getWeatherDataByCityName(cityName: String) {
        Task { [weak self] in
            guard let self = self else { return }
            let coordinatesByName = try await alamofireProvider.getCoordinatesByName(nameCity: cityName)
            guard let lat = coordinatesByName.first?.lat, let lon = coordinatesByName.first?.lon else {
                return print("Error city name")
            }
            let weatherDataByCoordinates = try await alamofireProvider.getWeatherForCityCoordinates(lat: lat, lon: lon)
            await MainActor.run {
                print(weatherDataByCoordinates)
            }
        }
    }
    
}
