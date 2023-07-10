//
//  PopularFlightView.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 23.06.23.
//

import SwiftUI
import Combine

struct PopularFlightView: View {
    
    //MARK: - Property -
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = PopularFlightViewModel()
    
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
    
    //MARK: - Popular tickets -
    var popularTickets: some View {
        ForEach(vm.popularFlightInfo) { i in
            CustomPopularTicketCell(popularFlightInfo: i)
        }
        .padding(.top, 16)
    } 

    //MARK: - Content -
    var content: some View {
        List {
            popularTickets
        }
        .buttonStyle(.plain)
    }

    //MARK: - Body -
    var body: some View {
        ZStack {
            Color(.homeBackgroundColor).ignoresSafeArea()
            
            VStack {
                content
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: buttonBack)
            .navigationTitle("Popular Flight")
        }
    }
}

struct PopularFlightView_Previews: PreviewProvider {
    static var previews: some View {
        PopularFlightView(vm: PopularFlightViewModel())
    }
}
