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
    func getUserDataDB(id: String) async throws -> UserModel
    func signUpWithEmail(email: String, password: String) async throws -> User
    func signInWithEmail(email: String, password: String) async throws -> User
    func createUserDataDB(firstName: String, lastName: String, email: String, dateOfBirth: Date, uid: String, urlImage: String, passport: String, country: String) async throws
    func createUserImageDataDB(imageAccount: String, id: String) async throws -> URL
    func saveTicket(uid: String, origin: String, destination: String, price: Int, flightNumber: String, departureDate: String, returnDate: String, duration: String, icon: String) async throws
    func getTicketsDB(id: String) async throws -> [TicketsFoundModel]
}

class FirebaseManager: FirebaseManagerProtocol {
    
    //MARK: - Property -
    private let db = Firestore.firestore()
    
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
    
    //MARK: - SingUp with Email -
    func signUpWithEmail(email: String, password: String) async throws -> User {
        try await Auth.auth().createUser(withEmail: email, password: password).user
    }
    
    //MARK: - SingIn with Email -
    func signInWithEmail(email: String, password: String) async throws -> User {
        try await Auth.auth().signIn(withEmail: email, password: password).user
    }
    
    //MARK: - Get user data DB -
    func getUserDataDB(id: String) async throws -> UserModel  {
         try await db.collection("Users").document(id).getDocument(as: UserModel.self)
    }
    
    //MARK: - Get tickets DB -
    func getTicketsDB(id: String) async throws -> [TicketsFoundModel]  {
        var array: [TicketsFoundModel] = []
        let tickets = try await db.collection("Users").document(id).collection("Tickets").getDocuments()
        array = try tickets.documents.map {try $0.data (as: TicketsFoundModel.self) }
        return array
    }
    
    //MARK: - Create user data DB -
    func createUserDataDB(firstName: String, lastName: String, email: String, dateOfBirth: Date, uid: String, urlImage: String, passport: String, country: String) async throws {
        let users  = UserModel(firstName: firstName, lastName: lastName, email: email, dateOfBirth: dateOfBirth, urlImage: urlImage, passport: passport, country: country)
        do {
           try db.collection("Users").document(uid).setData(from: users)
        } catch {
            print("Error add User")
        }
    }
    
    //MARK: - Create user image data db -
    func createUserImageDataDB(imageAccount: String, id: String) async throws -> URL {
        let ref = Storage.storage().reference().child("images").child(id)
            
        guard let fileURL = URL(string: imageAccount) else {
            fatalError("Invalid URL")
        }
        
        do {
            print (fileURL)
            let imageData = try Data(contentsOf: fileURL)
            guard let imageData = UIImage(data: imageData)?.jpegData(compressionQuality: 0.8) else {
                fatalError("Invalid image data")
            }
            
            let metadata = StorageMetadata()
            metadata.contentType = "images/jpeg"
            
            ref.putData(imageData, metadata: metadata)
        
            let downloadURLTask = try await ref.downloadURL()
            
            let db = Firestore.firestore()
            try await db.collection("Users").document(id).updateData(["urlImage": downloadURLTask.absoluteString])
            
            return downloadURLTask
        } catch {
            throw error
        }
    }
    
    //MARK: - Create user data DB -
    func saveTicket(uid: String, origin: String, destination: String, price: Int, flightNumber: String, departureDate: String, returnDate: String, duration: String, icon: String) async throws {
        do {
            let ticket  = TicketsFoundModel(data: DateTicket(origin: origin, destination: destination, originAirport: "", destinationAirport: "", price: price, airline: icon, flightNumber: flightNumber, departureAt: departureDate, returnAt: returnDate, transfers: 0, returnTransfers: 0, duration: Int(duration) ?? 0, durationTo: 0, link: ""))
            try db.collection("Users").document(uid).collection("Tickets").document(ticket.id.uuidString).setData(from: ticket)
        } catch {
            print("Error add User")
        }
    }
}
