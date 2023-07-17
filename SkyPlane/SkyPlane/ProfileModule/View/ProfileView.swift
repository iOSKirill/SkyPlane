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
    @StateObject var vm = ProfileViewModel()
    
    //MARK: - Header view -
    var headerProfile: some View {
        ZStack {
            Image(.headerProfile)
                .resizable()
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, maxHeight: 130)
            
            HStack {
                WebImage(url: URL(string: vm.userInfo.urlImage))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .mask(Circle())
                    .padding(.leading, 20)
                
                VStack(alignment: .leading,spacing: 8) {
                    Text(vm.userInfo.firstLastName())
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(Color(.whiteBlack))
                    Text(vm.userInfo.email)
                        .font(.system(size: 18, weight: .regular))
                        .foregroundColor(Color(.whiteBlack))
                }
                .padding(.leading, 16)
                Spacer()
            }
        }
    }
    
    //MARK: - Logout button -
    var logout: some View {
        Button {
            vm.logout()
        } label: {
            HStack {
                Image(.logout)
                Text("Logout")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(Color(.blackColor))
                    .padding(.vertical, 16)
            }
            .frame(maxWidth: .infinity)
            .background(Color(.basicColor))
            .cornerRadius(16)
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
    }
    
    //MARK: - Body - 
    var body: some View {
        NavigationView {
            ZStack {
                Color(.homeBackgroundColor).ignoresSafeArea()
                
                VStack {
                    headerProfile
                    VStack {
                        CustomProfileButton(view: EditProfileView(), nameItem: "Edit Profile", imageItem: .editProfile)
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
            .task {
                vm.getUserData()
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(vm: ProfileViewModel())
    }
}
