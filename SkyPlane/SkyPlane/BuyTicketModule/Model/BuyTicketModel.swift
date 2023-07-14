//
//  BuyTicketModel.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 7.07.23.
//

import Foundation

struct BuyTicketModel: Identifiable {
    var id = UUID()
    var selectClassName: String
    var cabingBag: String
    var changeFree: String
    var meal: String
    var cancellation: String
    
    init(classFlight: ClassFlight) {
        switch classFlight {
        case .economy:
            selectClassName = ClassFlight.economy.rawValue
            cabingBag = "4 Kg"
            changeFree = "$200"
            meal = "Free"
            cancellation = "Non-refundable"
        case .business:
            selectClassName = ClassFlight.business.rawValue
            cabingBag = "7 Kg"
            changeFree = "$120"
            meal = "Free"
            cancellation = "Refundable"
        }
    }
}
