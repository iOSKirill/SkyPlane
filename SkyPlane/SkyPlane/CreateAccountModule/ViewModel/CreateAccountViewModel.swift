//
//  CreateAccountViewModel.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 9.06.23.
//

import Foundation
import SwiftUI

final class CreateAccountViewModel: ObservableObject {
    
    //MARK: - Property -
    private var firebaseManager: FirebaseManagerProtocol = FirebaseManager()
    @AppStorage("appCondition", store: .standard) var appCondition: AppCondition = .onboardingView
    @Published var isPresentedLogin = false
    @Published var isSecurePassword = true
    @Published var isSecureConfirmPassword = true
    @Published var firstNameText: String = ""
    @Published var lastNameText: String = ""
    @Published var emailText: String = ""
    @Published var passwordText: String = ""
    @Published var passwordConfirmText: String = ""
    
    //MARK: - Sing In with Google -
    func singInWithGoogle() {
        Task { [weak self] in
            guard let self = self else { return }
            let user = try await firebaseManager.singInWithGoogle()
            await MainActor.run {
                self.appCondition = .homeView
            }
        }
    }
    
    //MARK: - Create User DB -
    func createUser() {
        Task { [weak self] in
            guard let self = self, passwordText == passwordConfirmText else { return print("Password")}
            let userInfo = try await firebaseManager.signUpWithEmail(email: emailText, password: passwordText)
            if userInfo.email != nil {
            
                //Save uid in UserDefaults
                UserDefaults.standard.set(userInfo.uid.description, forKey: "uid")
                
                //Create user data in db
                try await firebaseManager.createUserDataDB(firstName: firstNameText, lastName: lastNameText, email: emailText, dateOfBirth: .now, gender: "", uid: userInfo.uid, urlImage: "")
                
                await MainActor.run {
                    self.isPresentedLogin = true
                }
            }
        }
    }
}
