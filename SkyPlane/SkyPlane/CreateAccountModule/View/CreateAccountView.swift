//
//  CreateAccountView.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 9.06.23.
//

import SwiftUI

struct CreateAccountView: View {
    
    //MARK: - Property -
    @StateObject var vm = CreateAccountViewModel()
    
    var body: some View {
        //Button Continue with Google
        Button {
            vm.singInWithGoogle()
            print("Continue with Google")
        } label: {
            HStack {
                Image(.singInWithGoogle)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding()
                
                Text("Continue with Google")
                    .padding(.vertical, 16)
                    .fontDesign(.rounded)
                    .lineLimit(1)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color(.textBlackWhiteColor))
            }
            .padding(.horizontal, 40)
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color(.textBlackWhiteColor), lineWidth: 2))
        }
        .fullScreenCover(isPresented: $vm.isPresented) {
            OnboardingView()
        }
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
