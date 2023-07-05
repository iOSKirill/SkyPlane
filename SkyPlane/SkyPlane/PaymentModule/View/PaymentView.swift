//
//  PaymentView.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 3.07.23.
//

import SwiftUI
import SDWebImageSwiftUI

struct PaymentView: View {
    
    //MARK: - Property -
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = PaymentViewModel()
    
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
    
    var ticket: some View {
        ZStack {
            Image(.ticketBackground)
                .resizable()
            VStack(spacing: 8) {
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
                
                HStack {
                    Text(vm.buyTicketInfo.departureDate)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(Color(.textSilverWhite))
                        .padding(.leading, 32)
                    Spacer()
                    Text(vm.buyTicketInfo.flightNumber)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(Color(.textSilverWhite))
                        .padding(.trailing, 32)
                }
                
                HStack {
                    Text("------------------------------------------")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(Color(.textTicketColor))
                        .frame(maxWidth: .infinity)
                }
                .padding(.top, 16)
                
                HStack {
                    WebImage(url: URL(string: vm.imageURL))
                        .padding(.leading, 32)
                    Spacer()
                    switch vm.classFlight {
                    case .economy:
                        Text(vm.buyTicketInfo.price.formatCurrency())
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(Color(.textSilverWhite))
                            .padding(.trailing, 32)
                    case .business:
                        Text("\(((vm.buyTicketInfo.price) * 2).formatCurrency())")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(Color(.textSilverWhite))
                            .padding(.trailing, 32)
                    }
                }
            }
        }
        .padding(.horizontal, 22)
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
    }
    
    var datePicker: some View {
        ZStack(alignment: .leading) {
            HStack {
                Image(.datePicker)
                .padding(.leading, 16)
       
                Text("\(vm.date.dateFormatPayment())")
                    .font(.system(size: 16, weight: .medium, design: .default))
                    .frame(height: 60)
                    .overlay {
                        DatePicker("", selection: $vm.date, displayedComponents: [.date])
                            .blendMode(.destinationOver)
                    }
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color(.basicColor), lineWidth: 2)
            }
            .foregroundColor(Color(.textBlackWhiteColor))
            .background(Color(.homeBackgroundColor))
            .cornerRadius(16)
            
            Text("Expiry date")
                .foregroundColor(Color(.basicColor))
                .background(Color(.homeBackgroundColor))
                .font(.system(size: 18, weight: .medium, design: .default))
                .padding(.bottom, 60)
                .padding(.leading, 16)
        }
    }
    
    var confirmButton: some View {
        Button {
            vm.saveTicket()
        } label: {
            Text("Confirm")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(Color(.blackColor))
                .padding(16)
                .frame(maxWidth: .infinity)
                .background(Color(.basicColor))
                .cornerRadius(16)
        }
        .fullScreenCover(isPresented: $vm.isPresented) {
            BoordingPassView(vm: vm.boordingPassVM)
        }
    }
    var cancelButton: some View {
        Button {
            dismiss()
        } label: {
            Text("Cancel")
                .font(.system(size: 18, weight: .medium, design: .default))
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .foregroundColor(Color(.basicColor))
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color(.basicColor), lineWidth: 2)
                }
                .foregroundColor(Color(.textBlackWhiteColor))
                .cornerRadius(16)
        }
    }
    
    var body: some View {
        ZStack {
            Color(.homeBackgroundColor).ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack {
                    ticket
                        .padding(.top, 16)
                    VStack(alignment: .leading) {
                        CustomProfileTextField(bindingValue: $vm.cardNumber, textSection: "Card Number", textFieldValue: "0000 0000 0000 0000")
                        CustomProfileTextField(bindingValue: $vm.cardHolderName, textSection: "Card Holder Name", textFieldValue: "Enter your name")
                        HStack {
                            CustomProfileTextField(bindingValue: $vm.cvv, textSection: "CVV", textFieldValue: "000")
                            datePicker
                        }
                        Image(.cards)
                            .padding(.bottom, 16)
                        confirmButton
                        cancelButton
                    }
                    .padding(.horizontal, 16)
                    Spacer()
                }
            }
        }
        .navigationTitle("Payment")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: buttonBack)
    }
}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView(vm: PaymentViewModel())
    }
}
