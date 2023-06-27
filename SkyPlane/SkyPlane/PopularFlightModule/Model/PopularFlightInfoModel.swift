//
//  PopularFlightModel.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 26.06.23.
//

import Foundation

struct PopularFlightInfoModel: Identifiable {
    var id = UUID()
    var origin: String
    var destination: String
    var departureDate: String
    var flightNumber: Int
    var price: String
    var icon: String
    
    init(data: Datum) {
        origin = data.origin ?? ""
        destination = data.destination ?? ""
        departureDate = data.departureAt?.formatDateTicket() ?? ""
        flightNumber = data.flightNumber ?? 0
        price = data.price?.formatCurrency() ?? ""
        icon = data.airline ?? ""
    }
}

