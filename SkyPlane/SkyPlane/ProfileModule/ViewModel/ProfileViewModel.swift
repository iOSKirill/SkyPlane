//
//  ProfileViewModel.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 30.06.23.
//

import Foundation
import SwiftUI

final class ProfileViewModel: ObservableObject {
    
    //MARK: - Property -
    @AppStorage("appCondition", store: .standard) var appCondition: AppCondition = .onboardingView
    @Published var imageUrl: String = ""
    @Published var emailUser: String = ""
    @Published var firstAndLastNameUser: String = ""
    
    //MARK: - Get user data - 
    func getUserData() {
        imageUrl = UserData.shared.urlImage
        emailUser = UserData.shared.email
        firstAndLastNameUser = UserData.shared.firstLastName()
    }
    
    //MARK: - Logout -
    func logout() {
        appCondition = .createAccountView
    }
}
