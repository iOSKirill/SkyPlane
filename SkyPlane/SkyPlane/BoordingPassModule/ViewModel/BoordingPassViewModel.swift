//
//  BoordingPassViewModel.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 3.07.23.
//

import Foundation

final class BoordingPassViewModel: ObservableObject {
    
    //MARK: - Property -
    @Published var buyTicketInfo: TicketsFoundModel
    @Published var classFlight: ClassFlight = .economy
    @Published var isPresented: Bool = false
    @Published var userInfo = UserData.shared
    @Published var isShowingMailView = false

    init() {
        buyTicketInfo = TicketsFoundModel(data: DateTicket())
    }
    
    var imageURL: String {
           return "https://pics.avs.io/100/50/\(buyTicketInfo.icon).png"
    }
}
