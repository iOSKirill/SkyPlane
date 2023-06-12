//
//  LoginViewModel.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 12.06.23.
//

import Foundation
import SwiftUI

final class LoginViewModel: ObservableObject {
    
    //MARK: - Property -
    private var firebaseManager: FirebaseManagerProtocol = FirebaseManager()
    @Published var isPresentedGoogle = false
    @Published var isPresentedLogin = false
    @Published var isSecurePassword = true
    @Published var emailText: String = ""
    @Published var passwordText: String = ""
    
    //MARK: - Sing In with Google -
    func singInWithGoogle() {
        Task { [weak self] in
            guard let self = self else { return }
            let user = try await firebaseManager.singInWithGoogle()
            await MainActor.run {
                self.isPresentedGoogle = true
            }
        }
    }
    
    //MARK: - Login with e-mail -
    func loginUsers() {
        Task { [weak self] in
            guard let self = self else { return }
            let userInfo = try await firebaseManager.signInWithEmail(email: emailText, password: passwordText)
            UserDefaults.standard.set(userInfo.uid.description, forKey: "uid")
            await MainActor.run {
                self.isPresentedLogin = true
            }
        }
    }
    
}
