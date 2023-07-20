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
    @FocusState private var textIsFocused: Bool
    
    //MARK: - Search textField weather -
    var searchTextField: some View {
        HStack {
            CustomHomeTextField(bindingValue: $vm.nameSearchCity, textSection: "", textFieldValue: "Enter name city")
                .padding(.horizontal, 16)
                .focused($textIsFocused)
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
    }
    
    //MARK: - Currnet weather info -
    var currentWeather: some View {
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
    }
    
    //MARK: Hourly weather info -
    var hourlyWeather: some View {
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
    }
    
    //MARK: - Daily weather info -
    var dailyWeather: some View {
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
    
    //MARK: - ScrollView weather info -
    var scrollWeatherInfo: some View {
        VStack {
            searchTextField
            ScrollView(showsIndicators: false) {
                currentWeather
                hourlyWeather
                dailyWeather
            }
        }
    }
    
    //MARK: - Body -
    var body: some View {
        ZStack {
            Color(.homeBackgroundColor).ignoresSafeArea()
            
            Group {
                if vm.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .foregroundColor(.blue)
                        .padding()
                        .cornerRadius(10)
                        .shadow(radius: 5)
                } else {
                    scrollWeatherInfo
                }
            }
            .task {
                vm.getWeatherDataByCityName(cityName: "Minsk")
            }
            .onTapGesture {
                textIsFocused = false
            }
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}


