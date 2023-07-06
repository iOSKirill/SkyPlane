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
    private var locationManager = LocationManager()
    
       var userLatitude: String {
           return "\(locationManager.description)"
       }
    @Published var isPresented = false
    @Published var currentWeather: CurrenWeatherModel?
    @Published var hourlyWeather: [CurrenWeatherModel] = []
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
            let mappedCurrent = CurrenWeatherModel(data: weatherDataByCoordinates.current)
            let mappedHourly = weatherDataByCoordinates.hourly
                .map { CurrenWeatherModel(data: $0) }
            let mappedDaily = weatherDataByCoordinates.daily
                .map { DailyWeatherModel(data: $0) }
            await MainActor.run {
                self.hourlyWeather = mappedHourly
                self.currentWeather = mappedCurrent
                self.dailyWeather = mappedDaily
                self.nameCity = cityName
                self.nameSearchCity = ""
            }
        }
    }
}

import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()
    @Published var locationStatus: CLAuthorizationStatus?
    @Published var lastLocation: CLLocation?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

   
    
    var statusString: String {
        guard let status = locationStatus else {
            return "unknown"
        }
        
        switch status {
        case .notDetermined: return "notDetermined"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .authorizedAlways: return "authorizedAlways"
        case .restricted: return "restricted"
        case .denied: return "denied"
        default: return "unknown"
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationStatus = status
        print(#function, statusString)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        lastLocation = location
        print(#function, location)
    }
}
