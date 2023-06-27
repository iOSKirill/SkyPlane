//
//  DateFormatter+Extension.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 27.06.23.
//

import Foundation

extension String {
    
    //MARK: - Formatter date ticket -
    func formatDateTicket() -> String {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = inputDateFormatter.date(from: self) ?? Date()
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "MMM dd, HH:mm"
        let outputDateString = outputDateFormatter.string(from: date)
        return outputDateString
    }
}

