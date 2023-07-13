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
    func getTicketsAllDB(id: String) async throws -> [TicketsFoundModel]
    func getTicketsPastTripDB(id: String) async throws -> [TicketsFoundModel]
    func getTicketsUpcomingTripDB(id: String) async throws -> [TicketsFoundModel] 
    func createUserDataDB(firstName: String, lastName: String, email: String, dateOfBirth: Date, uid: String, urlImage: String, passport: String, country: String) async throws
    func saveTicket(uid: String, origin: String, destination: String, price: Int, flightNumber: String, departureDate: String, returnDate: String, duration: Int, icon: String) async throws
    func deleteMyTickets(ticket: TicketsFoundModel, id: String) async throws
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
    
    //MARK: - Get tickets all DB -
    func getTicketsAllDB(id: String) async throws -> [TicketsFoundModel]  {
        var array: [TicketsFoundModel] = []
        let tickets = try await db.collection("Users").document(id).collection("Tickets").getDocuments()
        array = try tickets.documents.map {try $0.data (as: TicketsFoundModel.self) }
        return array
    }
    
    //MARK: - Get tickets pasr trip DB -
    func getTicketsPastTripDB(id: String) async throws -> [TicketsFoundModel] {
        var array: [TicketsFoundModel] = []
        let tickets = try await db.collection("Users").document(id).collection("Tickets").getDocuments()
        array = try tickets.documents.map {try $0.data (as: TicketsFoundModel.self) }
        let filteredTickets = array.filter { $0.departureDate < Date.now.description }
        return filteredTickets
    }
    
    //MARK: - Get tickets upcoming trip  DB -
    func getTicketsUpcomingTripDB(id: String) async throws -> [TicketsFoundModel] {
        var array: [TicketsFoundModel] = []
        let tickets = try await db.collection("Users").document(id).collection("Tickets").getDocuments()
        array = try tickets.documents.map {try $0.data (as: TicketsFoundModel.self) }
        let filteredTickets = array.filter { $0.departureDate > Date.now.description }
        return filteredTickets
    }
    
    //MARK: - Create user data DB -
    func createUserDataDB(firstName: String, lastName: String, email: String, dateOfBirth: Date, uid: String, urlImage: String, passport: String, country: String) async throws {
        let users  = UserModel(firstName: firstName,
                               lastName: lastName,
                               email: email,
                               dateOfBirth: dateOfBirth,
                               urlImage: urlImage,
                               passport: passport,
                               country: country)
        do {
           try db.collection("Users").document(uid).setData(from: users)
        } catch {
            print("Error add User")
        }
    }
    
    //MARK: - Create user data DB -
    func saveTicket(uid: String, origin: String, destination: String, price: Int, flightNumber: String, departureDate: String, returnDate: String, duration: Int, icon: String) async throws {
        do {
            let ticket  = TicketsFoundModel(origin: origin,
                                            destination: destination,
                                            departureDate: departureDate,
                                            returnDate: returnDate,
                                            flightNumber: flightNumber,
                                            price: price,
                                            icon: icon,
                                            duration: duration)
            try db.collection("Users").document(uid).collection("Tickets").document(ticket.id.uuidString).setData(from: ticket)
        } catch {
            print("Error add User")
        }
    }
    
    //MARK: - Delete ticket from DB -
    func deleteMyTickets(ticket: TicketsFoundModel, id: String) async throws {
        try await db.collection("Users").document(id).collection("Tickets").document(ticket.id.uuidString).delete()
    }
}
