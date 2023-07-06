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
        ZStack {
            Color(.homeBackgroundColor).ignoresSafeArea()
            VStack {
                HStack {
                    CustomHomeTextField(bindingValue: $vm.nameSearchCity, textSection: "", textFieldValue: "Enter name city")
                        .padding(.horizontal, 16)
                    Spacer()
                    Button {
                        vm.getWeatherDataByCityName(cityName: vm.nameSearchCity)
                    } label: {
                        Image(.searchTabBar)
                            .padding(16)
                            .frame(maxWidth: .infinity)
                            .background(Color(.basicColor))
                            .cornerRadius(16)
                    }
                    .frame(width: 50)
                    .padding(.trailing, 16)
                }
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .center, spacing: 5) {
                        Text(vm.nameCity)
                            .font(.system(size: 50, weight: .bold))
                            .foregroundColor(Color(.textBlackWhiteColor))
                        Text("\(vm.currentWeather?.temp.customInt() ?? 0)°")
                            .font(.system(size: 50, weight: .bold))
                            .foregroundColor(Color(.textBlackWhiteColor))
                        Text(vm.currentWeather?.desctiption ?? "")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(Color(.textBlackWhiteColor))
                        Text(vm.dailyWeather.first?.maxMinTemp() ?? "")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(Color(.textBlackWhiteColor))
                    }

                    VStack {
                        HStack {
                            Text("Today")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(Color(.textBlackWhiteColor))
                                .padding(.leading, 16)
                                .padding(.top, 10)
                            Spacer()
                            Text(vm.currentWeather?.day.dateFormatter(dateFormat: .monthDay) ?? "")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(Color(.textBlackWhiteColor))
                                .padding(.trailing, 16)
                                .padding(.top, 10)
                        }
                        Divider()
                        ScrollView(.horizontal, showsIndicators: false) {
                            
                            HStack {
                                ForEach(vm.hourlyWeather.prefix(24)) { i in
                                    CustomHourlyWeatherCell(hourly: i)
                                }
                                .padding(.horizontal, 10)
                            }
                            .padding(.vertical, 5)
                            .cornerRadius(16)
                        }
                    }
                    .background(Color(.ticketBackgroundColor))
                    .cornerRadius(16)
                    .padding(.horizontal, 16)
                    
                    ScrollView(showsIndicators: false) {
                        HStack {
                            Text("Next Forecast")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(Color(.textBlackWhiteColor))
                                .padding(.leading, 16)
                            Spacer()
                            Image(.datePicker)
                                .padding(.trailing, 16)
                        }
                        .padding(.top, 10)
                        
                        Divider()
                        
                        ForEach(vm.dailyWeather.prefix(7)) { i in
                            CustomDailyWeatherCell(daily: i)
                        }
                    }
                    .background(Color(.ticketBackgroundColor))
                    .cornerRadius(16)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 5)
                }
            }
            .task {
                vm.getWeatherDataByCityName(cityName: "Minsk")
                print(vm.userLatitude)
            }
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}

extension Double {
    func customInt() -> Int {
        let intValue = Int(self)
        return intValue
    }
}
