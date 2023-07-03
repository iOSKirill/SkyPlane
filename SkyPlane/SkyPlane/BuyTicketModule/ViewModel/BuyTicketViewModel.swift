//
//  BuyTicketViewModel.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 28.06.23.
//

import Foundation

class Ticket {
    static let shared = Ticket()
    
    private init() {}
    
    var id = ""
    var origin = ""
    var destination = ""
    var departureDate = ""
    var returnDate = ""
    var flightNumber = ""
    var price = 0
    var icon = ""
    var duration = ""
    var classFlight: ClassFlight = .economy
    
    func saveInfo(ticket: TicketsFoundModel) {
        origin = ticket.origin
        destination = ticket.destination
        departureDate = ticket.departureDate
        returnDate = ticket.returnDate
        flightNumber = ticket.flightNumber
        price = ticket.price
        icon = ticket.icon
        duration = ticket.duration
        id = ticket.id.uuidString
    }
    
    func saveClassFlight(classFlight: ClassFlight) {
        self.classFlight = classFlight
    }
}

final class BuyTicketViewModel: ObservableObject {
    
    //MARK: - Property -
    @Published var buyTicketInfo: TicketsFoundModel
    @Published var classFlight: ClassFlight = .economy
    @Published var businessPrice: Int = 0

    init(buyTicketInfo: TicketsFoundModel) {
        self.buyTicketInfo = buyTicketInfo
    }
    
}
