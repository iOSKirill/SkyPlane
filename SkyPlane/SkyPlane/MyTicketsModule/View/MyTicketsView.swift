//
//  MyTicketsView.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 1.07.23.
//

import SwiftUI

struct MyTicketsView: View {
    
    //MARK: - Property -
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = MyTicketsViewModel()
    
    //MARK: - ButtonBack -
    var buttonBack: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "arrow.backward")
                .foregroundColor(Color(.textBlackWhiteColor))
                .padding(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color(.textBlackWhiteColor), lineWidth: 1)
                }
        }
    }
    
    //MARK: - Header view -
    var header: some View {
        VStack(spacing: 8) {
            ZStack {
                Image(.headerPlanet)
                    .resizable()
                    .ignoresSafeArea()
                    .frame(maxWidth: .infinity, maxHeight: 150)
            }
            Spacer()
        }
    }
    
    //MARK: - Filter button -
    var filterMyTickets: some View {
        HStack {
            Button {
                vm.getAllTicktes()
            } label: {
                Text("All")
                    .font(.system(size: 15, weight: .medium))
                    .fixedSize(horizontal: true, vertical: false)
                    .padding(.vertical,10)
                    .padding(.horizontal,40)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(vm.filter == .all ?  Color(.basicColor) : Color(.buttonTypesFlight), lineWidth: 2)
                    }
                    .background(vm.filter == .all ?  Color(.basicColor) : Color(.backgroundColor))
                    .foregroundColor(vm.filter == .all ? .black : Color(.textBlackWhiteColor))
                    .cornerRadius(15)
            }
            .frame(maxWidth: .infinity)
            .padding(.leading, 16)
            
            Button {
                vm.getUpcomingTripTicktes()
            } label: {
                Text("Upcoming Trip")
                    .font(.system(size: 15, weight: .medium))
                    .fixedSize(horizontal: true, vertical: false)
                    .padding(.vertical,10)
                    .padding(.horizontal,20)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(vm.filter == .upcomingTrip ? Color(.basicColor) : Color(.buttonTypesFlight), lineWidth: 2)
                    }
                    .background(vm.filter == .upcomingTrip ?  Color(.basicColor) : Color(.backgroundColor))
                    .foregroundColor(vm.filter == .upcomingTrip ? .black : Color(.textBlackWhiteColor))
                    .cornerRadius(15)
            }
            .frame(maxWidth: .infinity)
            
            Button {
                vm.getPastTripTicktes()
            } label: {
                Text("Past Trip")
                    .font(.system(size: 15, weight: .medium))
                    .fixedSize(horizontal: true, vertical: false)
                    .padding(.vertical,10)
                    .padding(.horizontal,20)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(vm.filter == .pastTrip ? Color(.basicColor) : Color(.buttonTypesFlight), lineWidth: 2)
                    }
                    .background(vm.filter == .pastTrip ?  Color(.basicColor) : Color(.backgroundColor))
                    .foregroundColor(vm.filter == .pastTrip ? .black : Color(.textBlackWhiteColor))
                    .cornerRadius(15)
            }
            .frame(maxWidth: .infinity)
            .padding(.trailing, 16)
        }
        .padding(.top, 30)
    }
    
    //MARK: - Body -
    var body: some View {
        ZStack {
            Color(.homeBackgroundColor).ignoresSafeArea()
            header
            
            if vm.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .foregroundColor(.blue)
                    .padding()
                    .cornerRadius(10)
                    .shadow(radius: 5)
            } else {
                    VStack {
                        filterMyTickets
                        if !vm.tickets.isEmpty {
                            List {
                                ForEach(vm.tickets) { i in
                                    CustomMyTicketsCell(ticketsFound: i)
                                }  .onDelete { index in
                                    vm.removeMyTicket(indexRemove: index)
                                }
                            }
                            .listStyle(.plain)
                            .padding(.top, 16)
                        } else {
                            VStack {
                                Image(.myTicketError)
                                Text("You don't have any registered tickets")
                                    .font(.system(size: 22, weight: .bold, design: .default))
                                    .multilineTextAlignment(.center)
                                Text("Tickets are automatically saved to favorites after it's purchase.")
                                    .font(.system(size: 20, weight: .regular, design: .default))
                                    .multilineTextAlignment(.center)
                                    .padding(.top, 10)
                            }
                            .padding(.horizontal, 16)
                            .frame(maxHeight: .infinity)
                        }
                    }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: buttonBack)
        .navigationTitle("My Tickets")
        .task {
            vm.getAllTicktes()
        }
    }
}

struct MyTicketsView_Previews: PreviewProvider {
    static var previews: some View {
        MyTicketsView()
    }
}
