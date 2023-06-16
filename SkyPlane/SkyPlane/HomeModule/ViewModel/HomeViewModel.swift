//
//  HomeViewModel.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 14.06.23.
//

import Foundation
import SwiftUI

final class HomeViewModel: ObservableObject {
    
    //MARK: - Property -
    private var alamofireProvider: AlamofireProviderProtocol = AlamofireProvider()
    @Published var isPresented = false
    
    //MARK: - Get flight info -
    func getFlightInfo(origin: String, destination: String, departureDate: String, returnDate: String) {
        Task { [weak self] in
            guard let self = self else { return }
            let flightInfo = try await alamofireProvider.getFlightsInfo(origin: origin, destination: destination, departureDate: departureDate, returnDate: returnDate)
            await MainActor.run {
                print(flightInfo)
            }
        }
    }
    
    //MARK: - Get popular flight info -
    func getPopularFlightInfo(cityName: String) {
        Task { [weak self] in
            guard let self = self else { return }
            let popularFlightInfo = try await alamofireProvider.getPopularFlightsByCityName(cityName: cityName)
            await MainActor.run {
                print(popularFlightInfo)
            }
        }
    }
    
}
