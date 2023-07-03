//
//  PrivacyPoliceView.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 1.07.23.
//

import SwiftUI

struct PrivacyPoliceView: View {
    
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
                Text("Please read these privacy policy, carefully before using our app operated by us.")
                    .font(.system(size: 18, weight: .regular))
                    .foregroundColor(Color(.textBlackWhiteColor))
                    .padding(.horizontal, 16)
                    .padding(.top, 32)
                
                Text("Privacy Policy")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(Color(.basicColor))
                    .padding(.horizontal, 16)
                    .padding(.top, 32)
                
                Text("There are many variations of sassages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable.If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text.All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary. making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable.The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.")
                    .font(.system(size: 18, weight: .regular))
                    .foregroundColor(Color(.textBlackWhiteColor))
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                Spacer()
            }
        }
        .navigationTitle("Privacy Policy")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: buttonBack)
    }
}

struct PrivacyPoliceView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPoliceView()
    }
}
