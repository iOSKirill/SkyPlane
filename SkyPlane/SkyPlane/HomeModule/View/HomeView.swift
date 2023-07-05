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
                CustomDatePickerTextField(selectedDate: $vm.selectedDateDeparture, showDatePicker: $vm.datePickerShow, textSection: "Departure", calendarId: $vm.calendarId)
                    .padding(.horizontal, 16)
            case .departureAndReturnDatePicker:
                CustomDatePickerTextField(selectedDate: $vm.selectedDateDeparture, showDatePicker: $vm.datePickerShow, textSection: "Departure", calendarId: $vm.calendarId)
                    .padding(.leading, 16)
                CustomDatePickerTextField(selectedDate: $vm.selectedDateReturn, showDatePicker: $vm.datePickerShow, textSection: "Return", calendarId: $vm.calendarId)
                    .padding(.trailing, 16)
            }
        }
    }
    
    //MARK: - Search button -
    var searchButton: some View {
        NavigationLink(destination: TicketsFoundView(vm: vm.ticketsFoundVM).onAppear {
            switch vm.datePickerShow {
            case .departureAndReturnDatePicker:
                vm.getFlightInfoRoundTrip()
            case .departureDatePicker:
                vm.getFlightInfoOneWay()
            }
        }) {
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
    }
    var changeTypeFlight: some View {
        HStack {
            
            Button {
                vm.datePickerShow = .departureDatePicker
            } label: {
                Text("One Way")
                    .font(.system(size: 15, weight: .medium))
                    .fixedSize(horizontal: true, vertical: false)
                    .padding(.vertical,10)
                    .padding(.horizontal,45)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(vm.datePickerShow == .departureDatePicker ?  Color(.basicColor) : Color(.buttonTypesFlight), lineWidth: 2)
                    }
                    .background(vm.datePickerShow == .departureDatePicker ?  Color(.basicColor) : Color(.ticketBackgroundColor))
                    .foregroundColor(vm.datePickerShow == .departureDatePicker ? .black : Color(.textBlackWhiteColor))
                    .cornerRadius(15)
            }
            
            Button {
                vm.datePickerShow = .departureAndReturnDatePicker
            } label: {
                Text("Round Trip")
                    .font(.system(size: 15, weight: .medium))
                    .fixedSize(horizontal: true, vertical: false)
                    .padding(.vertical,10)
                    .padding(.horizontal,45)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(vm.datePickerShow == .departureAndReturnDatePicker ? Color(.basicColor) : Color(.buttonTypesFlight), lineWidth: 2)
                    }
                    .background(vm.datePickerShow == .departureAndReturnDatePicker ?  Color(.basicColor) : Color(.ticketBackgroundColor))
                    .foregroundColor(vm.datePickerShow == .departureAndReturnDatePicker ? .black : Color(.textBlackWhiteColor))
                    .cornerRadius(15)
            }
            
        }.padding(.top, 16)
            .padding(.horizontal, 16)
    }

    //MARK: - Body -
    var body: some View {
        NavigationView {
            ZStack {
                Color(.homeBackgroundColor).ignoresSafeArea()
                
                VStack {
                    ZStack {
                        Image(.headerScreen)
                            .resizable()
                            .ignoresSafeArea()
                            .frame(maxWidth: .infinity, maxHeight: 250)
                    }
                    Spacer()
                }
                VStack(alignment: .leading, spacing: 0) {
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Hello \(vm.userInfo.firstName) 👋")
                            .font(.system(size: 22, weight: .regular))
                            .foregroundColor(Color(.backgroundColor))
                            .padding(.horizontal, 16)
                        Text("Find your flights")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(Color(.backgroundColor))
                            .padding(.horizontal, 16)
                    }
                    .padding(.vertical, 22)
                    
                    ScrollView(showsIndicators: false) {
                        VStack {
                            changeTypeFlight
                            originDestination
                            departureAndReturnDatePicker
                            
                            CustomPassengerAndClassTextField(isPresented: $vm.showHomeScreen, passengerValue: vm.passenger, classFlightValue: vm.classFlight, textFieldValue: "Enter passenger", textSection: "Passenger and class")
                                .padding(.horizontal, 16)
                            
                                searchButton
                        }
                        .frame(maxWidth: .infinity, maxHeight: 500)
                        .background(Color(.ticketBackgroundColor))
                        .cornerRadius(16)
                        .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 10)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        
                        HStack {
                            Text("Popular Flights")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(Color(.textBlackWhiteColor))
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.clear)
                            Spacer()
                       
                            NavigationLink {
                                PopularFlightView(vm: vm.popularFlightVM)
                            } label: {
                                Text("View All")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(Color(.textTicketColor))
                            }
                        }
                        .padding(.top, 16)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        .buttonStyle(.plain)
                        
                        //Popular tickets
                        ForEach(vm.popularFlightInfo.prefix(2)) { i in
                            CustomPopularTicketCell(popularFlightInfo: i)
                        }
                        .padding(.bottom, 8)
                    }
                    .padding(.horizontal, 16)
                    .buttonStyle(.plain)
                }
                .listStyle(.plain)
                
            }
            .task {
                vm.getPopularFlightInfo(cityName: "Minsk")
            }
        }
        .alert("Error", isPresented: $vm.isAlert) {
            Button("Cancel", role: .cancel) {}
        } message: {
            Text(vm.errorText)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(vm: HomeViewModel())
    }
}
