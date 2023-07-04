//
//  BoordingPassViewModel.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 3.07.23.
//

import Foundation

final class BoordingPassViewModel: ObservableObject {
    
    //MARK: - Property -
    @Published var buyTicketInfo: TicketsFoundModel = TicketsFoundModel(data: DateTicket(origin: "", destination: "", originAirport: "", destinationAirport: "", price: 0, airline: "", flightNumber: "", departureAt: "", returnAt: "", transfers: 0, returnTransfers: 0, duration: 0, duration_to: 0, link: ""))
    @Published var classFlight: ClassFlight = .economy
    @Published var isPresented: Bool = false
    @Published var dataUser: UserModel = UserModel(firstName: "", lastName: "", email: "", dateOfBirth: .now, urlImage: "", passport: "", country: "")
    
    var imageURL: String {
           return "https://pics.avs.io/100/50/\(buyTicketInfo.icon).png"
    }
}
