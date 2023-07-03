//
//  BoordingPassView.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 3.07.23.
//

import SwiftUI
import SDWebImageSwiftUI

struct BoordingPassView: View {
    
    //MARK: - Property -
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = BoordingViewModel()
    
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
    
    var body: some View {
        ZStack {
            Color(.homeBackgroundColor).ignoresSafeArea()
            
            header
            
            ScrollView {
                ZStack {
                    Image(.ticketBoording)
                        .resizable()
                    VStack(spacing: 8) {
                        
                        WebImage(url: URL(string: "https://pics.avs.io/100/50/\(vm.ticketInfo.icon).png"))
                            .padding(.top, 50)
                        
                        HStack {
                            Text(vm.ticketInfo.origin)
                                .font(.system(size: 22, weight: .bold))
                                .padding(.leading, 32)
                                .foregroundColor(Color(.textSilverWhite))
                            Spacer()
                            VStack {
                                Image(.logoOnTicket)
                                Text(vm.ticketInfo.duration)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(Color(.durationColor))
                            }
                            .padding(.top, 20)
                            Spacer()
                            Text(vm.ticketInfo.destination)
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(Color(.textSilverWhite))
                                .padding(.trailing, 32)
                        }
                        
                         Divider()
                            .padding(.horizontal, 32)
                            .padding(.top, 16)
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("DEPARTURE")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(Color(.textTicketColor))
                                Text("\(vm.userInfo.firstName) \(vm.userInfo.lastName)")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(Color(.textSilverWhite))
                                    .padding(.top, 1)
                                
                                Text("TERMIAl")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(Color(.textTicketColor))
                                    .padding(.top, 1)
                                Text("5")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(Color(.textSilverWhite))
                                    .padding(.top, 1)
                                
                                Text("DEPATURE")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(Color(.textTicketColor))
                                    .padding(.top, 1)
                                Text(vm.ticketInfo.departureDate)
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(Color(.textSilverWhite))
                                    .padding(.top, 1)
                            }
                            .padding(.leading, 32)
                            Spacer()
                            VStack(alignment: .trailing) {
                                Text("SEAT NUMBER")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(Color(.textTicketColor))
                                Text("B2")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(Color(.textSilverWhite))
                                    .padding(.top, 1)
                                
                                Text("CLASS")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(Color(.textTicketColor))
                                    .padding(.top, 1)
                                Text("aa")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(Color(.textSilverWhite))
                                    .padding(.top, 1)
                                
                                Text("PASSPORT ID")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(Color(.textTicketColor))
                                    .padding(.top, 1)
                                Text(vm.userInfo.passport)
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(Color(.textSilverWhite))
                                    .padding(.top, 1)
                            }
                            .padding(.trailing, 32)
                        }
                        .padding(.top, 8)
                        
                        Spacer()
                        
                        HStack {
                            Text("-------------------------------------")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(Color(.textTicketColor))
                                .frame(maxWidth: .infinity)
                        }
                        .padding(.top,1)
                        
                        HStack {
                            VStack {
                                Text("SCAN THIS BARCODE")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(Color(.basicColor))
                                    .padding(.top, 1)
                                Image(.barcode)
                                    .resizable()
                                    .frame(width: 250, height: 80)
                            }
                        }
                        .padding(.bottom, 50)
                        
                    }
                }
                .padding(.horizontal, 22)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            }
        }
        .navigationTitle("Boording Pass")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: buttonBack)
    }
}

struct BoordingPassView_Previews: PreviewProvider {
    static var previews: some View {
        BoordingPassView()
    }
}
