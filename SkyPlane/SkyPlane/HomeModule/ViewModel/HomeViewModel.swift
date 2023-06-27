//
//  HomeViewModel.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 14.06.23.
//

import Foundation
import SwiftUI
import Combine

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

enum ShowHomeScreen: String, Identifiable {
    case ticketsFoundView
    case passengerAndClassView
    
    var id: String {
        return self.rawValue
    }
}


final class HomeViewModel: ObservableObject {
    
    //MARK: - Property -
    private var alamofireProvider: AlamofireProviderProtocol = AlamofireProvider()
    private var cancellable = Set<AnyCancellable>()
    @Published var popularFlightVM = PopularFlightViewModel()
    @Published var popularFlightInfo: [PopularFlightInfoModel] = []
    @Published var showHomeScreen: ShowHomeScreen?
    
    init() {
        $popularFlightInfo
            .sink { item in
                self.popularFlightVM.popularFlightInfo = item
            }
            .store(in: &cancellable)
    }
    
    //Date picker
    @Published var selectedDateDeparture = Date()
    @Published var selectedDateReturn = Date()
    @Published var datePickerShow: DatePickerShow = .departureDatePicker
    
    //TextField
    @Published var originNameCity: String = ""
    @Published var destinationNameCity: String = ""
    @Published var passenger: String = "1 Adults"
    @Published var classFlight: ClassFlight = .economy
    
    let dateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

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
                    self.showHomeScreen = .ticketsFoundView
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
                let newDate =  Calendar.current.date(byAdding: .day, value: 1, to: selectedDateDeparture)
                let originCodeByCityName = try await alamofireProvider.getCodeByCityName(cityName: originNameCity)
                guard let codeOriginNameCity = originCodeByCityName.first?.code else { return }
                let destinationCodeByCityName = try await alamofireProvider.getCodeByCityName(cityName: destinationNameCity)
                guard let codeDestinationNameCity = destinationCodeByCityName.first?.code else { return }
                let flightInfo = try await alamofireProvider.getFlightsInfo(origin: codeOriginNameCity, destination: codeDestinationNameCity, departureDate: dateFormat.string(from: selectedDateDeparture), returnDate: dateFormat.string(from: newDate ?? .now))
                await MainActor.run {
                    self.showHomeScreen = .ticketsFoundView
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
                let codeByCityName = try await alamofireProvider.getCodeByCityName(cityName: cityName)
                guard let codeNameCity = codeByCityName.first?.code else { return }
                let popularFlightInfo = try await alamofireProvider.getPopularFlightsByCityName(cityName: codeNameCity)
                let mappedData = popularFlightInfo.data?.values.map { PopularFlightInfoModel(data: $0) } ?? []

                await MainActor.run {
                    self.popularFlightInfo = mappedData.sorted(by: { $0.price < $1.price })
                }
            } catch {
                print("Error get popular flight info")
            }
        }
    }
}
