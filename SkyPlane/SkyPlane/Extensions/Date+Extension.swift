//
//  Date+Extension.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 4.07.23.
//

import Foundation

extension Date {
    
    //MARK: - Date basic format -
    func dateFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.string(from: self)
    }
    
    //MARK: - Date format date expiry date -
    func dateFormatPayment() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/yy"
        return formatter.string(from: self)
    }
    
    //MARK: - Date formate search tickets -
    func dateFormatSearchTickets() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
    
}
