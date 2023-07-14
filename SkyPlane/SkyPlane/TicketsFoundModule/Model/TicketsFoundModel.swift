//
//  TicketsFoundModel.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 27.06.23.
//

import Foundation

struct TicketsFoundModel: Identifiable, Encodable, Decodable {
    var id = UUID()
    var origin: String
    var destination: String
    var departureDate: String
    var returnDate: String
    var flightNumber: String
    var price: Int
    var icon: String
    var duration: Int
    
    init(data: DateTicket) {
        origin = data.origin ?? ""
        destination = data.destination ?? ""
        departureDate = data.departureAt?.formatDateTicket() ?? ""
        returnDate = data.returnAt?.formatDateTicket() ?? ""
        flightNumber = data.flightNumber ?? ""
        price = data.price ?? 0
        icon = data.airline ?? ""
        duration = data.durationTo ?? 0
    }
    
    init(origin: String, destination: String, departureDate: String, returnDate: String, flightNumber: String, price: Int, icon: String, duration: Int) {
        self.origin = origin
        self.destination = destination
        self.departureDate = departureDate
        self.returnDate = returnDate
        self.flightNumber = flightNumber
        self.price = price
        self.icon = icon
        self.duration = duration
    }
    
    func iconFlight() -> String {
        return "https://pics.avs.io/100/50/\(icon).png"
    }
}
