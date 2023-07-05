//
//  CurrenWeatherModel.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 5.07.23.
//

import Foundation

struct CurrenWeatherModel: Identifiable, Encodable {
    var id = UUID()
    var temp: Double
    var icon: String
    var time: String
    var desctiption: String
    var day: Int
    
    init(data: Current) {
        temp = data.temp
        icon = data.weather.first?.icon ?? ""
        time = data.dt.dateFormatter(dateFormat: .hourly)
        desctiption = data.weather.first?.description ?? ""
        day = data.dt
    }
}
