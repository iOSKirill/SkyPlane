//
//  BuyTicketViewModel.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 28.06.23.
//

import Foundation


final class BuyTicketViewModel: ObservableObject {
    
    //MARK: - Property -
    @Published var buyTicketInfo: TicketsFoundModel
    @Published var classFlight: ClassFlight = .economy
    @Published var businessPrice: Int = 0

    init(buyTicketInfo: TicketsFoundModel) {
        self.buyTicketInfo = buyTicketInfo
    }
    
}
