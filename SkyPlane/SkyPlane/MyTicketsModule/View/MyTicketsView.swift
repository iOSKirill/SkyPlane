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
    
    var body: some View {
        ZStack {
            Color(.homeBackgroundColor).ignoresSafeArea()
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: buttonBack)
        .navigationTitle("My Tickets")
    }
}

struct MyTicketsView_Previews: PreviewProvider {
    static var previews: some View {
        MyTicketsView()
    }
}
