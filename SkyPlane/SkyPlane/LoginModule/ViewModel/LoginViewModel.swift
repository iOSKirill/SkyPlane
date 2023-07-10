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
    @AppStorage("appCondition", store: .standard) var appCondition: AppCondition = .onboardingView
    @Published var isSecurePassword = true
    @Published var emailText: String = ""
    @Published var passwordText: String = ""
    @Published var isAlert: Bool = false
    @Published var errorText = "" {
        didSet {
            isAlert = true
        }
    }
    
    //MARK: - Sing In with Google -
    func singInWithGoogle() {
        Task { [weak self] in
            guard let self = self else { return }
            let _ = try await firebaseManager.singInWithGoogle()
            await MainActor.run {
                self.appCondition = .homeView
            }
        }
    }
    
    //MARK: - Login with e-mail -
    func loginUsers() {
        Task { [weak self] in
            guard let self = self else { return }
            do {
                let userInfo = try await firebaseManager.signInWithEmail(email: emailText, password: passwordText)
                UserDefaults.standard.set(userInfo.uid.description, forKey: "uid")
                await MainActor.run {
                    self.appCondition = .homeView
                }
            } catch {
                await MainActor.run {
                    self.errorText = error.localizedDescription
                }
            }
        }
    }
    
}
