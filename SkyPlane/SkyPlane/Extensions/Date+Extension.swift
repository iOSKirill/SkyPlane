//
//  Date+Extension.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 4.07.23.
//

import Foundation

//MARK: - Enum date format -
enum DateFormat: String {
    case ddMMYYYY = "dd-MM-yyyy"
    case mmYY = "MM/yy"
    case yyyyMMDD = "yyyy-MM-dd"
}

extension Date {
    
    //MARK: - Date basic format -
    func dateFormat(_ format: DateFormat) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        return formatter.string(from: self)
    }
}
