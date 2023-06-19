//
//  CoordinateModel.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 14.06.23.
//

import Foundation

// MARK: - CoordinateModel -
struct CoordinateModel: Codable {
    var cityName: String?
    var localNames: [String: String]
    var lat: Double
    var lon: Double
    var country: String?
    
    enum CodingKeys: String, CodingKey {
        case lat, lon, country
        case cityName = "name"
        case localNames = "local_names"
    }
}
