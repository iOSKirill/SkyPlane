//
//  TicketsFoundViewModel.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 21.06.23.
//

import Foundation
import SwiftUI

//MARK: - Enum filter flight -
enum FilterFlight: String {
    case priceSorted = "price"
    case routeSorted = "route"
    case directSotred = "direct"
}

final class TicketsFoundViewModel: ObservableObject {
    
    //MARK: - Property -
    private var alamofireProvider: AlamofireProviderProtocol = AlamofireProvider()
    @Published var flightInfo: [TicketsFoundModel] = []
    @Published var originNameCity: String = ""
    @Published var destinationNameCity: String = ""
    @Published var filter: FilterFlight = .priceSorted
    
    //MARK: - Get flight info round trip -
    func getFilterFlightInfo(direct: Bool, sorting: FilterFlight) {
        Task { [weak self] in
            guard let self = self, let filterInfo = flightInfo.first else { return }
            do {
                let flightInfo = try await alamofireProvider.getFilterFlightInfo(origin: filterInfo.origin, destination: filterInfo.destination, departureDate: filterInfo.departureDate.formatFilterTicket(), returnDate: filterInfo.returnDate.formatFilterTicket(), direct: direct, sorting: sorting.rawValue)
                let mappedData = flightInfo.data
                    .map { TicketsFoundModel(data: $0) }
                await MainActor.run {
                    self.flightInfo = mappedData
                }
            } catch {
                print("Error get flight info")
            }
        }
    }
}
