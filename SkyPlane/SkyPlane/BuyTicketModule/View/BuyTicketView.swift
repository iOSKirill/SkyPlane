//
//  BuyTicketView.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 28.06.23.
//

import SwiftUI

struct BuyTicketView: View {
    
    //MARK: - Property -
    @ObservedObject var vm: BuyTicketViewModel
    
    var body: some View {
        Text(vm.buyTicketInfo.price)
    }
}

struct BuyTicketView_Previews: PreviewProvider {
    static var previews: some View {
        BuyTicketView(vm: BuyTicketViewModel(buyTicketInfo: .init(data: .init(origin: "", destination: "", originAirport: "", destinationAirport: "", price: 0, airline: "", flightNumber: "", departureAt: "", returnAt: "", transfers: 0, returnTransfers: 0, duration: 0, duration_to: 0, link: ""))))
    }
}
