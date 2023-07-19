//
//  EditProfileView.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 1.07.23.
//

import SwiftUI
import SDWebImageSwiftUI

//MARK: - Enum screen profile -
enum ScreenProfile {
    case profile
    case buyTicket
}

struct EditProfileView: View {
    
    //MARK: - Property -
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = EditProfileViewModel()
    @State var currentScreen: ScreenProfile = .profile
    @FocusState private var textIsFocused: Bool
    
    //MARK: - Button back -
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
    
    //MARK: - Image account -
    var imageAccount: some View {
        ZStack(alignment: .bottomTrailing) {
            WebImage(url: URL(string: vm.editProfileModel.urlImage))
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .mask(Circle())
            Button {
                vm.isPresented.toggle()
            } label : {
                Image(.changeImage)
            }
            .sheet(isPresented: $vm.isPresented) {
                ImagePicker(selectedImageUrl: $vm.editProfileModel.urlImage, sourceType: .photoLibrary)
            }
        }
        .padding(.top, 37)
        .padding(.bottom, 32)
    }
    
    //MARK: - Date picker date of birth-
    var datePicker: some View {
        ZStack(alignment: .leading) {
            HStack {
                Image(.datePicker)
                    .padding(.leading, 16)
                
                Text("\(vm.editProfileModel.dateOfBirth.dateFormat(.ddMMYYYY))")
                    .font(.system(size: 16, weight: .medium, design: .default))
                    .frame(height: 60)
                    .overlay {
                        DatePicker("", selection: $vm.editProfileModel.dateOfBirth, in: ...Date(), displayedComponents: [.date])
                            .blendMode(.destinationOver)
                    }
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color(.basicColor), lineWidth: 2)
            }
            .foregroundColor(Color(.textBlackWhiteColor))
            .background(Color(.homeBackgroundColor))
            .cornerRadius(16)
            
            Text("Date of Birthday")
                .foregroundColor(Color(.basicColor))
                .background(Color(.homeBackgroundColor))
                .font(.system(size: 18, weight: .medium, design: .default))
                .padding(.bottom, 60)
                .padding(.leading, 16)
        }
    }
    
    //MARK: - Update button -
    var updateButton: some View {
        Button {
            vm.updateUserData()
        } label: {
            Text("Update")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(Color(.blackColor))
                .padding(16)
                .frame(maxWidth: .infinity)
                .background(Color(.basicColor))
                .cornerRadius(16)
        }
        .alert(isPresented: $vm.updateAlert) {
            Alert(title: Text("Update"), message: Text("Data successfully updated!"), dismissButton: .default(Text("OK")))
        }

    }
    
    //MARK: - Skip button -
    var skipButton: some View {
        NavigationLink {
            PaymentView(vm: vm.paymentVM)
        } label: {
            Text("Skip")
                .font(.system(size: 18, weight: .medium, design: .default))
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .foregroundColor(Color(.basicColor))
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color(.basicColor), lineWidth: 2)
                }
                .foregroundColor(Color(.textBlackWhiteColor))
                .cornerRadius(16)
        }
        .padding(.bottom, 16)
    }
    
    //MARK: - Skip button error -
    var skipButtonError: some View {
        Button {
            vm.errorText = "Please fill in the passport and country information"
        } label: {
            Text("Skip")
                .font(.system(size: 18, weight: .medium, design: .default))
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .foregroundColor(Color(.basicColor))
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color(.basicColor), lineWidth: 2)
                }
                .foregroundColor(Color(.textBlackWhiteColor))
                .cornerRadius(16)
        }
    }
        
    //MARK: - Body -
    var body: some View {
        ZStack {
            Color(.homeBackgroundColor).ignoresSafeArea()
            
            VStack {
                imageAccount
                ScrollView(showsIndicators: false) {
                    CustomProfileСardHolderNameTextField(bindingValue: $vm.editProfileModel.firstName, textSection: "Fisrt Name", textFieldValue: "Enter your first name")
                        .focused($textIsFocused)
                    CustomProfileСardHolderNameTextField(bindingValue: $vm.editProfileModel.lastName, textSection: "Last Name", textFieldValue: "Enter your last name")
                        .focused($textIsFocused)
                    CustomProfileEmailTextField(textSection: "E-mail")
                    CustomProfileСardHolderNameTextField(bindingValue: $vm.editProfileModel.passport, textSection: "Passport", textFieldValue: "Enter your passport")
                        .focused($textIsFocused)
                    CustomProfileСardHolderNameTextField(bindingValue: $vm.editProfileModel.country, textSection: "Country", textFieldValue: "Enter your country")
                        .focused($textIsFocused)
                    datePicker
                    switch currentScreen {
                    case .profile:
                        updateButton
                            .padding(.bottom, 16)
                    case .buyTicket:
                        updateButton
                        if !vm.editProfileModel.passport.isEmpty, !vm.editProfileModel.country.isEmpty {
                            skipButton
                        } else {
                            skipButtonError
                        }
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 16)
        }
        .navigationTitle("Edit Profile")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: buttonBack)
        .alert("Error", isPresented: $vm.isAlert) {
            Button("Cancel", role: .cancel) {}
        } message: {
            Text(vm.errorText)
        }
        .onTapGesture {
            textIsFocused = false
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(vm: EditProfileViewModel())
    }
}
