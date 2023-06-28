//
//  Int+Extension.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 27.06.23.
//

import Foundation

extension Int {
    
    //MARK: - Formatter price ticket -
    func formatCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        let formattedValue = formatter.string(from: NSNumber(value: self)) ?? ""
        return formattedValue
    }
    
    //MARK: - Formatter duration ticket -
    func formatDuration() -> String {
        let hours = self / 60
        let remainingMinutes = self % 60
        let formattedString = String(format: "%dh/%dm", hours, remainingMinutes)
        return formattedString
    }
}
