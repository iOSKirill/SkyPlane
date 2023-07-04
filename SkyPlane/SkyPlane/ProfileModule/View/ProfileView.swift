//
//  ProfileView.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 30.06.23.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileView: View {
    
    //MARK: - Property -
    @ObservedObject var vm: ProfileViewModel
    
    var headerProfile: some View {
        ZStack {
            Image(.headerProfile)
                .resizable()
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, maxHeight: 130)
            
            HStack {
                WebImage(url: URL(string: vm.dataUser.urlImage))
                    .resizable()
                    .frame(width: 80, height: 80)
                    .mask(Circle())
                    .padding(.leading, 20)
                
                VStack(alignment: .leading,spacing: 8) {
                    Text(vm.dataUser.firstLastName())
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(Color(.whiteBlack))
                    Text(vm.dataUser.email)
                        .font(.system(size: 18, weight: .regular))
                        .foregroundColor(Color(.whiteBlack))
                }
                .padding(.leading, 16)
                Spacer()
            }
        }
    }
    
    var logout: some View {
        Button {
            vm.logout()
        } label: {
            Text("Logout")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(Color(.blackColor))
                .padding(16)
                .frame(maxWidth: .infinity)
                .background(Color(.basicColor))
                .cornerRadius(16)
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.homeBackgroundColor).ignoresSafeArea()
                
                VStack {
                    headerProfile
                    VStack {
                        CustomProfileButton(view: EditProfileView(vm: vm.editProfileVM), nameItem: "Edit Profile", imageItem: .editProfile)
                        CustomProfileButton(view: MyTicketsView(), nameItem: "My Tickets", imageItem: .ticketProfile)
                        CustomProfileButton(view: PrivacyPoliceView(), nameItem: "Privacy Policy", imageItem: .privacyPolicyProfile)
                        CustomProfileButton(view: TermsConditionsView(), nameItem: "Terms & Conditions", imageItem: .termsProfile)
                    }
                    .padding(.top, 32)
                    Spacer()
                    logout
                }
            }
            .navigationBarTitle(Text("My Profile"), displayMode: .inline)
           
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(vm: ProfileViewModel())
    }
}
