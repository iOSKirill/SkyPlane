//
//  DailyWeatherModel.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 5.07.23.
//

import Foundation

struct DailyWeatherModel: Identifiable, Encodable {
    var id = UUID()
    var tempMax: Double
    var tempMin: Double
    var icon: String
    var day: String
    
    init(data: Daily) {
        tempMax = data.temp.max
        tempMin = data.temp.min
        icon = data.weather.first?.icon ?? ""
        day = data.dt.dateFormatter(dateFormat: .daily)
    }
    
    func returnIcon() -> String {
        "https://openweathermap.org/img/wn/\(icon).png"
    }
}
