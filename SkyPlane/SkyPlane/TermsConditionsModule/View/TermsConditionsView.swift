//
//  TermsConditionsView.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 1.07.23.
//

import SwiftUI

struct TermsConditionsView: View {
    //MARK: - Property -
    @Environment(\.dismiss) var dismiss
    
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
            
            VStack(alignment: .leading) {
                Text("Please read these terms of service, carefully before using our app operated by us.")
                    .font(.system(size: 18, weight: .regular))
                    .foregroundColor(Color(.textBlackWhiteColor))
                    .padding(.horizontal, 16)
                    .padding(.top, 32)
                
                Text("Conditions of Uses")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(Color(.basicColor))
                    .padding(.horizontal, 16)
                    .padding(.top, 32)
                
                Text("It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).")
                    .font(.system(size: 18, weight: .regular))
                    .foregroundColor(Color(.textBlackWhiteColor))
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                Spacer()
            }
        }
        .navigationTitle("Terms & Conditions")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: buttonBack)
    }
}

struct TermsConditionsView_Previews: PreviewProvider {
    static var previews: some View {
        TermsConditionsView()
    }
}
