//
//  TicketsFoundView.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 21.06.23.
//

import SwiftUI

struct TicketsFoundView: View {
    
    //MARK: - Property -
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = TicketsFoundViewModel()
    
    //MARK: - ButtonBack -
    var buttonBack: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "arrow.backward")
                .foregroundColor(Color(.whiteBlack))
                .padding(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color(.whiteBlack), lineWidth: 1)
                }
        }
    }
    
    var flightInfo: some View {
        ForEach(vm.flightInfo) { i in
            NavigationLink(destination: BuyTicketView(vm: BuyTicketViewModel(buyTicketInfo: i) )) {
                CustomTicketsFoundCell(ticketsFound: i, originFullName: vm.originNameCity, destinationFullName: vm.destinationNameCity)
            }
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .padding(.top, 16)
    
    }
    
    var filterFligth: some View {
        HStack {
            Button {
                vm.filter = .priceSorted
                vm.getFilterFlightInfo(direct: false, sorting: .priceSorted)
            } label: {
                Text("Price")
                    .font(.system(size: 15, weight: .medium))
                    .fixedSize(horizontal: true, vertical: false)
                    .padding(.vertical,10)
                    .padding(.horizontal,40)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(vm.filter == .priceSorted ?  Color(.basicColor) : Color(.buttonTypesFlight), lineWidth: 2)
                    }
                    .background(vm.filter == .priceSorted ?  Color(.basicColor) : Color(.backgroundColor))
                    .foregroundColor(vm.filter == .priceSorted ? .black : Color(.textBlackWhiteColor))
                    .cornerRadius(15)
            }
            .frame(maxWidth: .infinity)
            .padding(.leading, 16)
            
            Button {
                vm.filter = .routeSorted
                vm.getFilterFlightInfo(direct: false, sorting: .routeSorted)
            } label: {
                Text("Popular")
                    .font(.system(size: 15, weight: .medium))
                    .fixedSize(horizontal: true, vertical: false)
                    .padding(.vertical,10)
                    .padding(.horizontal,30)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(vm.filter == .routeSorted ? Color(.basicColor) : Color(.buttonTypesFlight), lineWidth: 2)
                    }
                    .background(vm.filter == .routeSorted ?  Color(.basicColor) : Color(.backgroundColor))
                    .foregroundColor(vm.filter == .routeSorted ? .black : Color(.textBlackWhiteColor))
                    .cornerRadius(15)
            }
            .frame(maxWidth: .infinity)
            
            Button {
                vm.filter = .directSotred
                vm.getFilterFlightInfo(direct: true, sorting: .priceSorted)
            } label: {
                Text("Transfers")
                    .font(.system(size: 15, weight: .medium))
                    .fixedSize(horizontal: true, vertical: false)
                    .padding(.vertical,10)
                    .padding(.horizontal,30)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(vm.filter == .directSotred ? Color(.basicColor) : Color(.buttonTypesFlight), lineWidth: 2)
                    }
                    .background(vm.filter == .directSotred ?  Color(.basicColor) : Color(.backgroundColor))
                    .foregroundColor(vm.filter == .directSotred ? .black : Color(.textBlackWhiteColor))
                    .cornerRadius(15)
            }
            .frame(maxWidth: .infinity)
            .padding(.trailing, 16)
        }
        .padding(.top, 16)
    }

    var content: some View {
        VStack {
            ZStack(alignment: .bottom) {
                Image(.headerTicketsFound)
                    .resizable()
                    .ignoresSafeArea()
                    .frame(maxWidth: .infinity, maxHeight: 150)
                HStack {
                    Text(vm.flightInfo.first?.origin ?? "")
                        .font(.system(size: 32, weight: .bold))
                        .padding(.leading, 62)
                        .foregroundColor(Color(.whiteBlack))
                    Spacer()
                    Text(vm.flightInfo.first?.destination ?? "")
                        .font(.system(size: 32, weight: .bold))
                        .padding(.trailing, 62)
                        .foregroundColor(Color(.whiteBlack))
                }
                .padding(.bottom, 70)
                
                Text("\(vm.flightInfo.count) Flights Available")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(Color(.whiteBlack))
                    .padding(.bottom, 16)
            }
            filterFligth
            ScrollView {
                if vm.flightInfo.count > 0 {
                    flightInfo
                } else {
                    Text("There are no tickets in this direction!")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(Color(.textBlackWhiteColor))
                        .multilineTextAlignment(.center)
                }
            }
            .buttonStyle(.plain)
            .listStyle(.plain)
        }
    }
    
    var body: some View {
        ZStack {
            Color(.homeBackgroundColor).ignoresSafeArea()
            VStack {

                content
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: buttonBack)
        .navigationTitle("")
    }
}

struct TicketsFoundView_Previews: PreviewProvider {
    static var previews: some View {
        TicketsFoundView(vm: TicketsFoundViewModel())
    }
}
