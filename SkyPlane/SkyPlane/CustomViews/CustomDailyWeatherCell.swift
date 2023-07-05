//
//  CustomDailyWeatherCell.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 5.07.23.
//

import SwiftUI
import SDWebImageSwiftUI

struct CustomDailyWeatherCell: View {
    var daily: DailyWeatherModel
    var body: some View {
        HStack(alignment: .center) {
            Text("\(daily.day)")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(Color(.textBlackWhiteColor))
                .padding(.leading, 16)
            Spacer()
            WebImage(url: URL(string: "https://openweathermap.org/img/wn/\(daily.icon).png"))
                .padding(.trailing, 50)
            Text("\(daily.tempMax.customInt())°")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(Color(.textBlackWhiteColor))
            Text("\(daily.tempMin.customInt())°")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(Color(.tabBarWhiteGray))
                .padding(.trailing, 16)
        }
    }
}

