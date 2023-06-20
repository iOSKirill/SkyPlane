//
//  HomeViewModel.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 14.06.23.
//

import Foundation
import SwiftUI

enum ClassFlight: String {
    case economy = "Economy"
    case comfort = "Comfort"
    case business = "Business"
    case firstClass = "First Class"
}

enum DatePickerShow {
    case departureDatePicker
    case departureAndReturnDatePicker
}

final class HomeViewModel: ObservableObject {
    
    //MARK: - Property -
    private var alamofireProvider: AlamofireProviderProtocol = AlamofireProvider()
    @Published var isPresentedSearchView = false
    @Published var isPresentedPassenger = false
    @Published var isPresentedClass = false
    
    //Date picker
    @Published var showDatePickerDeparture = false
    @Published var selectedDateDeparture = Date()
    @Published var showDatePickerReturn = false
    @Published var selectedDateReturn = Date()
    @Published var datePickerShow: DatePickerShow = .departureDatePicker
        
    let dateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    //TextField
    @Published var originNameCity: String = ""
    @Published var destinationNameCity: String = ""
    @Published var passenger: String = "1 Adults"
    @Published var classFlight: ClassFlight = .economy
    
    //Flight Info
    @Published var origin: String = ""
    @Published var destination: String = ""
    @Published var departureAt: String = ""
    @Published var flightNumber: String = ""
    @Published var duration: Int = 0
    @Published var duration_to: Int = 0
    @Published var price: Int = 0
    
    //MARK: - Get flight info round trip -
    func getFlightInfoRoundTrip() {
        Task { [weak self] in
            guard let self = self, !originNameCity.isEmpty, !destinationNameCity.isEmpty  else { return }
            do {
                let originCodeByCityName = try await alamofireProvider.getCodeByCityName(cityName: originNameCity)
                guard let codeOriginNameCity = originCodeByCityName.first?.code else { return }
                let destinationCodeByCityName = try await alamofireProvider.getCodeByCityName(cityName: destinationNameCity)
                guard let codeDestinationNameCity = destinationCodeByCityName.first?.code else { return }
                
                let flightInfo = try await alamofireProvider.getFlightsInfo(origin: codeOriginNameCity, destination: codeDestinationNameCity, departureDate: dateFormat.string(from: selectedDateDeparture), returnDate: dateFormat.string(from: selectedDateReturn))
                await MainActor.run {
                    self.isPresentedSearchView = true
                    guard let origin = flightInfo.data?.first?.origin else { return }
                    self.origin = origin
                    print(flightInfo)
                }
            } catch {
                print("Error get flight info")
            }
        }
    }
    
    //MARK: - Get flight info one way -
    func getFlightInfoOneWay() {
        Task { [weak self] in
            guard let self = self, !originNameCity.isEmpty, !destinationNameCity.isEmpty  else { return }
            do {
                let calendar = Calendar.current
                var dateComponents = DateComponents()
                let newDate = calendar.date(byAdding: dateComponents, to: selectedDateDeparture)
                
                let originCodeByCityName = try await alamofireProvider.getCodeByCityName(cityName: originNameCity)
                guard let codeOriginNameCity = originCodeByCityName.first?.code else { return }
                let destinationCodeByCityName = try await alamofireProvider.getCodeByCityName(cityName: destinationNameCity)
                guard let codeDestinationNameCity = destinationCodeByCityName.first?.code else { return }

                let flightInfo = try await alamofireProvider.getFlightsInfo(origin: codeOriginNameCity, destination: codeDestinationNameCity, departureDate: dateFormat.string(from: selectedDateDeparture), returnDate: dateFormat.string(from: newDate ?? .now))
                await MainActor.run {
                    self.isPresentedSearchView = true
                    guard let origin = flightInfo.data?.first?.origin else { return }
                    self.origin = origin
                    print(flightInfo)
                }
            } catch {
                print("Error get flight info")
            }
        }
    }
    
    //MARK: - Get popular flight info -
    func getPopularFlightInfo(cityName: String) {
        Task { [weak self] in
            guard let self = self else { return }
            do {
                let popularFlightInfo = try await alamofireProvider.getPopularFlightsByCityName(cityName: cityName)
                await MainActor.run {
                    print(popularFlightInfo)
                }
            } catch {
                print("Error get popular flight info")
            }
        }
    }
}
