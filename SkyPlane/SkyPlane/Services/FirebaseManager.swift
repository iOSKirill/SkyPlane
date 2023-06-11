//
//  FirebaseManager.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 9.06.23.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestoreSwift
import GoogleSignIn

//MARK: - Protocol Firebase -
protocol FirebaseManagerProtocol {
    func singInWithGoogle() async throws -> User
}

class FirebaseManager: FirebaseManagerProtocol {
    
    //MARK: - SingIn with Googl -
    func singInWithGoogle() async throws -> User {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { fatalError("error") }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        guard let windowScene =  await UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window =  await windowScene.windows.first,
              let rootViewController =  await window.rootViewController else { fatalError("error") }
        
        do {
            let signIn = try await  GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
            let user = signIn.user
            guard let idToken = user.idToken else { fatalError("error") }
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString,
                                                           accessToken: user.accessToken.tokenString)
            let result = try await Auth.auth().signIn(with: credential)
            let firebaseUser = result.user
            return firebaseUser
        } catch {
            print(error.localizedDescription)
            throw error
        }
        
    }

}
