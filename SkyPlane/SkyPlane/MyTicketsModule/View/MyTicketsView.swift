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
            
            ScrollView(showsIndicators: false) {
                ForEach(vm.tickets) { i in
                    CustomTicketsFoundCell(ticketsFound: i, originFullName: "", destinationFullName: "")
                }
            }
            .padding(.top, 30)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: buttonBack)
        .navigationTitle("My Tickets")
        .task {
            vm.getTicktes()
        }
    }
}

struct MyTicketsView_Previews: PreviewProvider {
    static var previews: some View {
        MyTicketsView()
    }
}
