//
//  FlightModel.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 15.06.23.
//

import Foundation

//MARK: - FlightInfo -
struct FlightInfo: Codable {
    let success: Bool?
    let data: [DateTicket]
    let currency: String?
}

//MARK: - DateElements -
struct DateTicket: Codable, Hashable {
    let origin, destination, originAirport, destinationAirport: String?
    let price: Int?
    let airline, flightNumber: String?
    let departureAt, returnAt: String?
    let transfers, returnTransfers, duration, durationTo: Int?
    let link: String?

    enum CodingKeys: String, CodingKey {
        case origin, destination
        case originAirport = "origin_airport"
        case destinationAirport = "destination_airport"
        case price, airline
        case flightNumber = "flight_number"
        case departureAt = "departure_at"
        case returnAt = "return_at"
        case transfers
        case returnTransfers = "return_transfers"
        case duration, link
        case durationTo = "duration_to"
    }
    
    init() {
        self.origin = ""
        self.destination = ""
        self.originAirport = ""
        self.destinationAirport = ""
        self.price = 0
        self.airline = ""
        self.flightNumber = ""
        self.departureAt = ""
        self.returnAt = ""
        self.transfers = 0
        self.returnTransfers = 0
        self.duration = 0
        self.durationTo = 0
        self.link = ""
    }
    
       init(origin: String, destination: String, originAirport: String, destinationAirport: String, price: Int, airline: String, flightNumber: String, departureAt: String, returnAt: String, transfers: Int, returnTransfers: Int, duration: Int, durationTo: Int, link: String) {
           self.origin = origin
           self.destination = destination
           self.originAirport = originAirport
           self.destinationAirport = destinationAirport
           self.price = price
           self.airline = airline
           self.flightNumber = flightNumber
           self.departureAt = departureAt
           self.returnAt = returnAt
           self.transfers = transfers
           self.returnTransfers = returnTransfers
           self.duration = duration
           self.durationTo = durationTo
           self.link = link
       }
}
