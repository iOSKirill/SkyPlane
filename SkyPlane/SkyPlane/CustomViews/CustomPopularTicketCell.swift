//
//  CustomTicketCell.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 22.06.23.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI

struct CustomPopularTicketCell: View {
    //MARK: - Property -
    var popularFlightInfo: PopularFlightInfoModel
    
    var body: some View {
        ZStack {
            Image(.ticketBackground)
                .resizable()
            VStack(spacing: 8) {
                HStack {
                    Text(popularFlightInfo.origin)
                        .font(.system(size: 22, weight: .bold))
                        .padding(.leading, 32)
                        .foregroundColor(Color(.textSilverWhite))
                    Spacer()
                    Image(.logoOnTicket)
                    Spacer()
                    Text(popularFlightInfo.destination)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(Color(.textSilverWhite))
                        .padding(.trailing, 32)
                }
                .padding(.top, 32)
                
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
                .padding(.top, 32)
                
                HStack {

                    Text(popularFlightInfo.departureDate)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(Color(.textSilverWhite))
                        .padding(.leading, 32)
                    Spacer()
                    Text("\(popularFlightInfo.flightNumber)")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(Color(.textSilverWhite))
                        .padding(.trailing, 32)
                }
                .padding(.bottom, 32)
                
                HStack {
                    Text("------------------------------------------")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(Color(.textTicketColor))
                        .frame(maxWidth: .infinity)
                }
                .padding(.top, 16)
                
                HStack {
                    WebImage(url: URL(string: "https://pics.avs.io/100/50/\(popularFlightInfo.icon).png"))
                        .padding(.leading, 32)
                    Spacer()
                    Text(popularFlightInfo.price)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(Color(.textSilverWhite))
                        .padding(.trailing, 32)
                }
            }
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
    }
}


