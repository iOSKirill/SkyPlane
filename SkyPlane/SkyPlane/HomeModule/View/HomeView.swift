//
//  HomeView.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 14.06.23.
//

import SwiftUI

struct HomeView: View {
    
    //MARK: - Property -
    @StateObject var vm = HomeViewModel()
    
    //MARK: - Origin Destination textField -
    var originDestination: some View {
        ZStack(alignment: .trailing) {
            VStack {
                CustomHomeTextField(bindingValue: $vm.originNameCity, textSection: "From", textFieldValue: "Enter your origin")
                    .padding(.horizontal, 16)
                CustomHomeTextField(bindingValue: $vm.destinationNameCity, textSection: "To", textFieldValue: "Enter your destination")
                    .padding(.horizontal, 16)
            }
            Circle()
                .foregroundColor(Color(.basicColor))
                .frame(maxWidth: 60, maxHeight: 60)
                .overlay {
                    Image(.arrowsHome)
                        .resizable()
                        .scaledToFit()
                        .padding()
                }
                .padding(.trailing, 42)
        }
    }
    
    //MARK: - Departure and Return DatePicker textField-
    var departureAndReturnDatePicker: some View {
        HStack {
            switch vm.datePickerShow {
            case .departureDatePicker:
                CustomDatePickerTextField(selectedDate: $vm.selectedDateDeparture, showDatePicker: $vm.showDatePickerDeparture, textSection: "Departure")
                    .padding(.horizontal, 16)
            case .departureAndReturnDatePicker:
                CustomDatePickerTextField(selectedDate: $vm.selectedDateDeparture, showDatePicker: $vm.showDatePickerDeparture, textSection: "Departure")
                    .padding(.leading, 16)
                CustomDatePickerTextField(selectedDate: $vm.selectedDateReturn, showDatePicker: $vm.showDatePickerReturn, textSection: "Return")
                    .padding(.trailing, 16)
            }
        }
    }
    
    //MARK: - Search button -
    var searchButton: some View {
        Button {
            switch vm.datePickerShow {
            case .departureAndReturnDatePicker:
                vm.getFlightInfoRoundTrip()
            case .departureDatePicker:
                vm.getFlightInfoOneWay()
            }
        } label: {
            Text("Search")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(Color(.blackColor))
                .padding(16)
                .frame(maxWidth: .infinity)
                .background(Color(.basicColor))
                .cornerRadius(16)
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
        }
        .fullScreenCover(isPresented: $vm.isPresentedSearchView) {
            CreateAccountView()
        }
    }
    var changeTypeFlight: some View {
        HStack {
            
            Button {
                vm.datePickerShow = .departureDatePicker
            } label: {
                Text("One Way")
                    .font(.system(size: 18, weight: .medium))
                    .padding(.vertical,10)
                    .padding(.horizontal,45)
                    .background(vm.datePickerShow == .departureDatePicker ?  Color(.basicColor) : Color(.ticketBackgroundColor))
                    .foregroundColor(vm.datePickerShow == .departureDatePicker ? .black : Color(.textBlackWhiteColor))
                    .cornerRadius(15)
            }
            
            Button {
                vm.datePickerShow = .departureAndReturnDatePicker
            } label: {
                Text("Round Trip")
                    .font(.system(size: 18, weight: .medium))
                    .padding(.vertical,10)
                    .padding(.horizontal,45)
                    .background(vm.datePickerShow == .departureAndReturnDatePicker ?  Color(.basicColor) : Color(.ticketBackgroundColor))
                    .foregroundColor(vm.datePickerShow == .departureAndReturnDatePicker ? .black : Color(.textBlackWhiteColor))
                    .cornerRadius(15)
            }
            
        }
    }

    //MARK: - Body -
    var body: some View {
        ZStack {
            Color(.homeBackgroundColor).ignoresSafeArea()
            
            VStack {
                HStack {
                    changeTypeFlight
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background(Color(.ticketBackgroundColor))
                .cornerRadius(16)
                .padding(.horizontal, 16)
                .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 0)
                
                VStack {
                    originDestination
                    departureAndReturnDatePicker
                    
                    CustomPassengerAndClassTextField(passengerValue: $vm.passenger, classFlightValue: $vm.classFlight, isPresented: $vm.isPresentedPassenger, textFieldValue: "Enter passenger", textSection: "Passenger and class")
                        .padding(.horizontal, 16)
                    
                    searchButton
                }
                .frame(maxWidth: .infinity, maxHeight: 480)
                .background(Color(.ticketBackgroundColor))
                .cornerRadius(16)
                .padding(.horizontal, 16)
                .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 0)
            }

        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
