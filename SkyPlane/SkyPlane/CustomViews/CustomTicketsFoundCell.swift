//
//  CustomTicketsFoundCell.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 28.06.23.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI

struct CustomTicketsFoundCell: View {
    
    //MARK: - Property -
    var ticketsFound: TicketsFoundModel
    var originFullName: String
    var destinationFullName: String
    
    var body: some View {
        ZStack {
            Image(.ticketBackground)
                .resizable()
            VStack(spacing: 8) {
                HStack {
                    Text(ticketsFound.origin)
                        .font(.system(size: 22, weight: .bold))
                        .padding(.leading, 32)
                        .foregroundColor(Color(.textSilverWhite))
                    Spacer()
                    VStack {
                        Image(.logoOnTicket)
                        Text(ticketsFound.duration)
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(Color(.durationColor))
                    }
                    .padding(.top, 20)
                    Spacer()
                    Text(ticketsFound.destination)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(Color(.textSilverWhite))
                        .padding(.trailing, 32)
                }
                
                
                HStack {
                    Text(originFullName)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(Color(.textSilverWhite))
                        .padding(.leading, 32)
                    Spacer()
                    Text(destinationFullName)
                        .font(.system(size: 18, weight: .regular))
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
                    Text(ticketsFound.departureDate)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(Color(.textSilverWhite))
                        .padding(.leading, 32)
                    Spacer()
                    Text("\(ticketsFound.flightNumber)")
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
                    WebImage(url: URL(string: "https://pics.avs.io/100/50/\(ticketsFound.icon).png"))
                        .padding(.leading, 32)
                    Spacer()
                    Text(ticketsFound.price)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(Color(.textSilverWhite))
                        .padding(.trailing, 32)
                }
            }
        }
        .padding(.horizontal, 22)
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
    }
}

