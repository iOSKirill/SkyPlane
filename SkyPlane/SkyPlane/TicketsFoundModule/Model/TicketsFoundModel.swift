//
//  TicketsFoundModel.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 27.06.23.
//

import Foundation

struct TicketsFoundModel: Identifiable {
    var id = UUID()
    var origin: String
    var destination: String
    var departureDate: String
    var returnDate: String
    var flightNumber: String
    var price: String
    var icon: String
    var duration: String
    
    init(data: DateTicket) {
        origin = data.origin ?? ""
        destination = data.destination ?? ""
        departureDate = data.departureAt?.formatDateTicket() ?? ""
        returnDate = data.returnAt?.formatDateTicket() ?? ""
        flightNumber = data.flightNumber ?? ""
        price = data.price?.formatCurrency() ?? ""
        icon = data.airline ?? ""
        duration = data.duration_to?.formatDuration() ?? ""
    }
}
