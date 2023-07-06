//
//  CustomHourlyWeatherCell.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 5.07.23.
//

import SwiftUI
import SDWebImageSwiftUI

struct CustomHourlyWeatherCell: View {
    var hourly: CurrenWeatherModel
    var body: some View {
        VStack {
            Text("\(hourly.time)")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(Color(.textBlackWhiteColor))
                .padding(.top, 5)
            WebImage(url: URL(string: hourly.returnIcon()))
            Text("\(hourly.temp.customInt())°C")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(Color(.textBlackWhiteColor))
                .padding(.bottom, 10)
        }
        .frame(width: 65)
        .background(Color(.ticketBackgroundColor))
        .background()
    }
}
