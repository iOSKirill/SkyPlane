//
//  PopularFlightModel.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 26.06.23.
//

import Foundation

struct PopularFlightInfoModel: Identifiable {
    var id = UUID()
    var origin: String
    var destination: String
    var departureDate: String
    var flightNumber: Int
    var price: String
    var icon: String
    
    init(data: Datum) {
        origin = data.origin ?? ""
        destination = data.destination ?? ""
        departureDate = formatDateTicket(data.departureAt ?? "")
        flightNumber = data.flightNumber ?? 0
        price = formatCurrency(data.price ?? 0)
        icon = data.airline ?? ""
    }
}

//MARK: - Formatter price ticket -
func formatCurrency(_ value: Int) -> String {
    let formatter = NumberFormatter()
    formatter.usesGroupingSeparator = true
    formatter.numberStyle = .currency
    formatter.locale = Locale.current
    let formattedValue = formatter.string(from: NSNumber(value: value)) ?? ""
    return formattedValue
}

//MARK: - Formatter date ticket -
func formatDateTicket(_ departureDate: String) -> String {
    let inputDateFormatter = DateFormatter()
    inputDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    let date = inputDateFormatter.date(from: departureDate) ?? Date()
    let outputDateFormatter = DateFormatter()
    outputDateFormatter.dateFormat = "MMM dd, HH:mm"
    let outputDateString = outputDateFormatter.string(from: date)
    return outputDateString
}
