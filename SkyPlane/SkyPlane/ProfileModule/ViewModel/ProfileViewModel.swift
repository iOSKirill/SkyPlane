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
    @Published var userInfo = UserData.shared
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: "uid")
        appCondition = .createAccountView
    }
}
