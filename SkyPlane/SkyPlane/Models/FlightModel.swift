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
    let data: [DateTicket]?
    let currency: String?
}

//MARK: - DateElements -
struct DateTicket: Codable {
    let origin, destination, originAirport, destinationAirport: String?
    let price: Int?
    let airline, flightNumber: String?
    let departureAt, returnAt: String?
    let transfers, returnTransfers, duration, duration_to: Int?
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
        case duration, link, duration_to
    }
}
