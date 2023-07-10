//
//  BuyTicketView.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 28.06.23.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI

struct BuyTicketView: View {
    
    //MARK: - Property -
    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm: BuyTicketViewModel
    
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
    
    //MARK: - Ticket info -
    var ticket: some View {
            ZStack() {
                Image(.buyTicketBackground)
                    .resizable()
                    .frame(maxHeight: 400)
                VStack(spacing: 8) {
                    
                    WebImage(url: URL(string: vm.imageURL))
                    
                    HStack {
                        Text("---------------------------------------------")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(Color(.textTicketColor))
                            .frame(maxWidth: .infinity)
                    }
                    
                    HStack {
                        Text(vm.buyTicketInfo.origin)
                            .font(.system(size: 22, weight: .bold))
                            .padding(.leading, 32)
                            .foregroundColor(Color(.textSilverWhite))
                        Spacer()
                        VStack {
                            Image(.logoOnTicket)
                            Text(vm.buyTicketInfo.duration)
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(Color(.durationColor))
                        }
                        .padding(.top, 20)
                        Spacer()
                        Text(vm.buyTicketInfo.destination)
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(Color(.textSilverWhite))
                            .padding(.trailing, 32)
                    }
                    .padding(.horizontal, 16)
                    
                    HStack {
                        Text(vm.buyTicketInfo.origin)
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(Color(.textSilverWhite))
                            .padding(.leading, 32)
                        Spacer()
                        Text(vm.buyTicketInfo.destination)
                            .font(.system(size: 18, weight: .regular))
                            .foregroundColor(Color(.textSilverWhite))
                            .padding(.trailing, 32)
                    }
                    .padding(.horizontal, 16)
                    
                    HStack {
                        Text("DEPARTURE")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(Color(.textTicketColor))
                            .padding(.leading, 32)
                        Spacer()
                        Text("FLIGHT NUMBER")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(Color(.textTicketColor))
                            .padding(.trailing, 32)
                    }
                    .padding(.top, 8)
                    .padding(.horizontal, 16)
                    
                    HStack {
                        Text(vm.buyTicketInfo.departureDate)
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(Color(.textSilverWhite))
                            .padding(.leading, 32)
                        Spacer()
                        Text("\(vm.buyTicketInfo.flightNumber)")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(Color(.textSilverWhite))
                            .padding(.trailing, 32)
                    }
                    .padding(.horizontal, 16)
                    
                    Spacer()
                    HStack {
                        Text("----------------------------------------")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(Color(.textTicketColor))
                            .frame(maxWidth: .infinity)
                    }
                    
                    HStack {
                        switch vm.classFlight {
                        case .economy:
                            Text("Price: \(vm.buyTicketInfo.price.formatCurrency())")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(Color(.textSilverWhite))
                        case .business:
                            Text("Price: \((vm.buyTicketInfo.price * 2).formatCurrency())")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(Color(.textSilverWhite))
                        }
                    }
                    .padding(.top, 8)
                    .padding(.bottom, 16)
                }
                .frame(maxHeight: 320)
            }
    }
    
    //MARK: - Header view -
    var headerPlanet: some View {
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
    
    //MARK: - Select class flight -
    var classFlight: some View {
        ScrollView(.horizontal) {
            HStack {
                CustomSelectClass(selectClass: $vm.classFlight,
                                  selectClassItem: .economy,
                                  buyTicketModel: .init(classFlight: .economy))
                CustomSelectClass(selectClass: $vm.classFlight,
                                  selectClassItem: .business,
                                  buyTicketModel: .init(classFlight: .business))
            }
        } 
        .scrollIndicators(.never)
        .frame(height: 250)
        .padding(.bottom, 16)
    }
    
    //MARK: - Confirm button -
    var confirmButton: some View {
        NavigationLink {
            EditProfileView(vm: vm.editProfileVM, currentScreen: .buyTicket)
        } label: {
            Text("Confirm")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(Color(.blackColor))
                .padding(16)
                .frame(maxWidth: .infinity)
                .background(Color(.basicColor))
                .cornerRadius(16)
                .padding(.horizontal, 16)
        }
    }
    
    //MARK: - Name section -
    var nameSection: some View {
        HStack {
            Text("Select Your Class")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(Color(.textBlackWhiteColor))
                .padding(.leading, 16)
            Spacer()
        }
    }
    
    //MARK: - Body -
    var body: some View {
        ZStack(alignment: .top) {
            Color(.homeBackgroundColor).ignoresSafeArea()
            
            headerPlanet
            ScrollView {
                ticket
                nameSection
                classFlight
                confirmButton
                    .padding(.bottom, 10)
            }
            .scrollIndicators(.never)
            .frame(width: UIScreen.main.bounds.width)
            .buttonStyle(.plain)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: buttonBack)
        .navigationTitle("Fligth Details")
    }
}

struct BuyTicketView_Previews: PreviewProvider {
    static var previews: some View {
        BuyTicketView(vm: BuyTicketViewModel(buyTicketInfo: .init(data: .init())))
    }
}
