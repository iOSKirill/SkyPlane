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
    
    //MARK: - Formatter filter ticket -
    func formatFilterTicket() -> String {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "MMM dd, HH:mm"
        let date = inputDateFormatter.date(from: self) ?? Date()
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "2023-MM-dd"
        let outputDateString = outputDateFormatter.string(from: date)
        return outputDateString
    }
    
    func formatCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        
        guard let floatValue = Float(self), let _ = formatter.number(from: self) else {
            return ""
        }
        
        let multipliedValue = floatValue * 2
        let multipliedNumber = NSNumber(value: multipliedValue)
        
        let formattedValue = formatter.string(from: multipliedNumber) ?? ""
        return formattedValue
    }
    
}

