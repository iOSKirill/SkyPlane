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
                if vm.tickets.count > 0 {
                    ScrollView(showsIndicators: false) {
                        ForEach(vm.tickets) { i in
                            CustomMyTicketsCell(ticketsFound: i)
                        }
                    }
                    .padding(.top, 30)
                } else {
                    VStack {
                        Text("There are no tickets purchased")
                            .font(.system(size: 22, weight: .medium, design: .default))
                    }
                }
            }
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
