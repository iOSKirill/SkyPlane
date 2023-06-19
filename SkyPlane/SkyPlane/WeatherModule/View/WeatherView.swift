//
//  WeatherView.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 14.06.23.
//

import SwiftUI

struct WeatherView: View {
    
    //MARK: - Property -
    @StateObject var vm = WeatherViewModel()
    
    //MARK: - Body -
    var body: some View {
        Text("Weather")
            .task {
                vm.getWeatherDataByCityName(cityName: "Minsk")
            }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
