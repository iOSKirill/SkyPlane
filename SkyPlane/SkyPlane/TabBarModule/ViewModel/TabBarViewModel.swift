//
//  TabBarViewModel.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 4.07.23.
//

import Foundation
import UIKit
import UserNotifications

//MARK: - Singleton user data -
class UserData {
    static let shared = UserData()
    
    private init() {}

    var firstName = ""
    var lastName = ""
    var email = ""
    var dateOfBirth: Date = .now
    var urlImage = ""
    var passport = ""
    var country = ""
    
    func saveInfo(user: UserModel) {
        firstName = user.firstName
        lastName =  user.lastName
        email = user.email
        dateOfBirth = user.dateOfBirth
        urlImage = user.urlImage
        passport = user.passport
        country = user.country
    }
    
    func getInfo() -> UserModel {
        UserModel(firstName: firstName, lastName: lastName, email: email, dateOfBirth: dateOfBirth, urlImage: urlImage, passport: passport, country: country)
    }
    
    func firstLastName() -> String {
        return "\(firstName) \(lastName)"
    }
}

final class TabBarViewModel: ObservableObject {
    
    //MARK: - Property -
    private var firebaseManager: FirebaseManagerProtocol = FirebaseManager()
    private var uid = UserDefaults.standard.string(forKey: "uid")
    
    //MARK: - Get user data and a singleton entry -
    func getUserData() {
        Task {
            do {
                let data = try await firebaseManager.getUserDataDB(id: uid ?? "")
                UserData.shared.saveInfo(user: data)
                userNotifications()
            } catch {
                print(error)
            }
        }
    }
    
    //MARK: - User notifications -
    func userNotifications()
    {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) {_,_ in }
    }
}
