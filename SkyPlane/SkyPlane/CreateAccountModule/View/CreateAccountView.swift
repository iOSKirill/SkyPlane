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
    
    var headerText: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Welcome!")
                    .foregroundColor(Color(.textBlackWhiteColor))
                    .font(.system(size: 32, weight: .semibold, design: .default))
                Text("Create account to continue")
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
    var createAccountButton: some View {
        Button {
            vm.createUser()
        } label: {
            Text("Create account")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(Color(.blackColor))
                .padding(16)
                .frame(maxWidth: .infinity)
                .background(Color(.basicColor))
                .cornerRadius(16)
                .padding(.bottom, -10)
        }
        .fullScreenCover(isPresented: $vm.isPresentedLogin) {
            LoginView()
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .padding(.top, 32)
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
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .padding(.bottom, -10)
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
        .fullScreenCover(isPresented: $vm.isPresentedGoogle) {
            TabBarView()
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
    }
    
    //MARK: - Present login view -
    var presentLoginViewButton: some View {
        HStack {
            Text("Already have an account?")
                .foregroundColor(Color(.textSilverWhite))
                .font(.system(size: 16, weight: .regular))
            NavigationLink {
                LoginView()
            } label: {
                Text("Login")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color(.basicColor))
                    .underline()
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 16)
    }

    //MARK: - Body -
    var body: some View {
        NavigationView {
            ZStack {
                Color(.backgroundColor).ignoresSafeArea()
                VStack {
                    List {
                        headerText
                        CustomSectionTextField(bindingValue: $vm.firstNameText, textSection: "First Name", textFieldValue: "Enter your first name")
                        CustomSectionTextField(bindingValue: $vm.lastNameText, textSection: "Last Name", textFieldValue: "Enter your last name")
                        CustomSectionTextField(bindingValue: $vm.emailText, textSection: "E-mail", textFieldValue: "Enter your email")
                        CustomSectionTextFieldPassword(bindingValue: $vm.passwordText, secureValue: $vm.isSecurePassword, textSection: "Password", textFieldValue: "Enter your password")
                        CustomSectionTextFieldPassword(bindingValue: $vm.passwordConfirmText, secureValue: $vm.isSecureConfirmPassword, textSection: "Confirm Password", textFieldValue: "Confirm your password")

                            createAccountButton
                            divider
                            loginWithGoogleButton
                    }
                    .listStyle(.plain)
                    .padding(.top, 1)
                    presentLoginViewButton
                }
                
            }
            .navigationBarTitle(Text("Registration"), displayMode: .inline)
        }
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
