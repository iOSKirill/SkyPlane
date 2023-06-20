//
//  Autocomplete.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 20.06.23.
//

import Foundation

//MARK: - Autocomplete -
struct Autocomplete: Codable {
    let type: String?
    let code, name, countryCode, countryName: String?
    let stateCode: String?
    let coordinates: Coordinates?
    let indexStrings: [String]?
    let weight: Int?
    let cases, countryCases, mainAirportName: String?

    enum CodingKeys: String, CodingKey {
        case type, code, name
        case countryCode = "country_code"
        case countryName = "country_name"
        case stateCode = "state_code"
        case coordinates
        case indexStrings = "index_strings"
        case weight, cases
        case countryCases = "country_cases"
        case mainAirportName = "main_airport_name"
    }
}

//MARK: - Coordinates -
struct Coordinates: Codable {
    let lon, lat: Double?
}
