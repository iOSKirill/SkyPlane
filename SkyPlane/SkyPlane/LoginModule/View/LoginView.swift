//
//  LoginView.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 12.06.23.
//

import SwiftUI

struct LoginView: View {
    
    //MARK: - Property -
    @StateObject var vm = LoginViewModel()
    @Environment(\.dismiss) var dismiss
    
    //MARK: - ButtonBack -
    var buttonBack : some View {
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
    
    var headerText: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Welcome back!")
                    .foregroundColor(Color(.textBlackWhiteColor))
                    .font(.system(size: 32, weight: .semibold, design: .default))
                Text("Login to continue")
                    .foregroundColor(Color(.textBlackWhiteColor))
                    .font(.system(size: 15, weight: .regular, design: .default))
            }
            Spacer()
            Circle()
                .foregroundColor(Color(.silverColor))
                .frame(maxWidth: 70, maxHeight: 70)
                .overlay {
                    Image(.logoBlackGreen)
                        .resizable()
                        .scaledToFit()
                        .padding()
                }
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .padding(.bottom, 16)
    }
    
    //MARK: - Create account button -
    var loginButton: some View {
        Button {
            vm.loginUsers()
        } label: {
            Text("Login")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(Color(.blackColor))
                .padding(16)
                .frame(maxWidth: .infinity)
                .background(Color(.basicColor))
                .cornerRadius(16)
                .padding(.bottom, -10)
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 10)
    }
    
    //MARK: - Divider -
    var divider: some View {
        HStack(alignment: .center) {
            VStack {
                Divider()
                    .frame(maxWidth: .infinity, maxHeight: 1)
                    .background(Color(.textSilverWhite))
            }
            Text("Or continue with")
                .font(.system(size: 14, weight: .regular, design: .default))
                .padding()
                .fixedSize(horizontal: true, vertical: false)
            VStack {
                Divider()
                    .frame(maxWidth: .infinity, maxHeight: 1)
                    .background(Color(.textSilverWhite))
            }
        }
        .padding(.bottom, 10)
        .padding(.horizontal, 16)
    }
    
    //MARK: - Login with google Button -
    var loginWithGoogleButton: some View {
        Button {
            vm.singInWithGoogle()
        } label: {
            HStack {
                Image(.singInWithGoogle)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(8)
                
                Text("Sing up with google")
                    .padding(.vertical, 16)
                    .fontDesign(.rounded)
                    .lineLimit(1)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color(.textSilverWhite))
            }
            .frame(maxWidth: .infinity)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color(.textSilverWhite), lineWidth: 1))
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
    }
    
    var body: some View {
        ZStack {
            Color(.backgroundColor).ignoresSafeArea()
            
            VStack {
                List {
                    headerText
                    CustomSectionTextField(bindingValue: $vm.emailText, textSection: "E-mail", textFieldValue: "Enter your email")
                    CustomSectionTextFieldPassword(bindingValue: $vm.passwordText, secureValue: $vm.isSecurePassword, textSection: "Password", textFieldValue: "Enter your password")
                }
                .listStyle(.plain)
                .scrollDisabled(true)
                
                loginButton
                divider
                loginWithGoogleButton
            }
            .padding(.top, 16)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: buttonBack)
        .navigationTitle("Login")
        .alert("Error", isPresented: $vm.isAlert) {
            Button("Cancel", role: .cancel) {}
        } message: {
            Text(vm.errorText)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
