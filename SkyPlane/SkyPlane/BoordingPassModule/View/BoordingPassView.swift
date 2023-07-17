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
    @StateObject var vm = BoordingPassViewModel()
    
    //MARK: - Button back -
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
    
    //MARK: - Header -
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
    
    //MARK: - Download ticket in photoAlbum-
    var downloadTicketButton: some View {
        Button {
            vm.requestPhotoPermissions()
            vm.saveViewTicket()
        } label: {
            Text("Download ticket")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(Color(.blackColor))
                .padding(16)
                .frame(maxWidth: .infinity)
                .background(Color(.basicColor))
                .cornerRadius(16)
        }
        .alert(isPresented: $vm.isImageSaved) {
            Alert(title: Text("Success"), message: Text("Your ticket has been successfully saved in the photo album!"), dismissButton: .default(Text("OK")))
        }
        .padding(.horizontal, 16)
    }
    
    //MARK: - Send by email button -
    var sendByEmailButton: some View {
        Button {
            vm.isShowingMailView.toggle()
        } label: {
            Text("Send by email")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(Color(.blackColor))
                .padding(16)
                .frame(maxWidth: .infinity)
                .background(Color(.basicColor))
                .cornerRadius(16)
        }
        .sheet(isPresented: $vm.isShowingMailView) {
            MailView(result: self.$vm.isShowingMailView, buyTicketInfo: vm.buyTicketInfo, classFlight: ClassFlight(rawValue: vm.classFlight.rawValue) ?? .economy)
        }
        .padding(.horizontal, 16)
    }
    
    //MARK: - Back to home button -
    var backHomeView: some View {
        Button {
            vm.isPresented.toggle()
        } label: {
            Text("Book another flight")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(Color(.basicColor))
                .padding(16)
                .frame(maxWidth: .infinity)
                .background(.clear)
                .cornerRadius(16)
        }
        .fullScreenCover(isPresented: $vm.isPresented) {
            TabBarView()
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
    }
    
    var ticketInfo: some View {
        VStack(spacing: 8) {
            
            WebImage(url: URL(string: vm.imageURL))
                .padding(.top, 50)
            
            HStack {
                Text(vm.buyTicketInfo.origin)
                    .font(.system(size: 22, weight: .bold))
                    .padding(.leading, 32)
                    .foregroundColor(Color(.textSilverWhite))
                Spacer()
                VStack {
                    Image(.logoOnTicket)
                    if vm.buyTicketInfo.duration > 0 {
                        Text(vm.buyTicketInfo.duration.formatDuration())
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(Color(.durationColor))
                    } else {
                        Text("")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(Color(.durationColor))
                    }
                }
                .padding(.top, 20)
                Spacer()
                Text(vm.buyTicketInfo.destination)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(Color(.textSilverWhite))
                    .padding(.trailing, 32)
            }
            
             Divider()
                .padding(.horizontal, 32)
                .padding(.top, 16)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("FIO")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(Color(.textTicketColor))
                    Text(vm.userInfo.firstLastName())
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
                    Text(vm.buyTicketInfo.departureDate)
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
                    Text(vm.classFlight.rawValue)
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
    
    //MARK: - Body -
    var body: some View {
        ZStack {
            Color(.homeBackgroundColor).ignoresSafeArea()
            
            header
            
            ScrollView(showsIndicators: false) {
                ZStack {
                    Image(.ticketBoording)
                        .resizable()
                    ticketInfo
                  
                }
                .padding(.horizontal, 22)
                downloadTicketButton
                sendByEmailButton
                backHomeView
            }
        }
        .navigationTitle("Boording Pass")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: buttonBack)
    }
}

struct BoordingPassView_Previews: PreviewProvider {
    static var previews: some View {
        BoordingPassView(vm: BoordingPassViewModel())
    }
}
