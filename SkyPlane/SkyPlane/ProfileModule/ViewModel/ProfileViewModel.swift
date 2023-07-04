//
//  ProfileViewModel.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 30.06.23.
//

import Foundation
import SwiftUI
import Combine

final class ProfileViewModel: ObservableObject {
    
    //MARK: - Property -
    @AppStorage("appCondition", store: .standard) var appCondition: AppCondition = .onboardingView
    private var cancellable = Set<AnyCancellable>()
    @Published var editProfileVM = EditProfileViewModel()
    @Published var dataUser: UserModel = UserModel(firstName: "", lastName: "", email: "", dateOfBirth: .now, urlImage: "", passport: "", country: "")
    init() {
        $dataUser
            .sink { item in
                self.editProfileVM.dataUser = item
                print(item.firstName)
            }
            .store(in: &cancellable)
    }
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: "uid")
        appCondition = .createAccountView
    }
}
