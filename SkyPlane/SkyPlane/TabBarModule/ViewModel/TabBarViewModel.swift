//
//  TabBarViewModel.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 4.07.23.
//

import Foundation
import Photos
import UIKit

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
    @Published var showPhotoPermissionAlert: Bool = false
    
    //MARK: - Get user data and a singleton entry -
    func getUserData() {
        Task {
            do {
                let data = try await firebaseManager.getUserDataDB(id: uid ?? "")
                UserData.shared.saveInfo(user: data)
            } catch {
                print(error)
            }
        }
    }
    
    //MARK: - Request photo permissions -
    func requestPhotoPermissions() {
        PHPhotoLibrary.requestAuthorization { status in
            if status != .authorized {
                self.showPhotoPermissionAlert = true
            }
        }
    }
      
    //MARK: - Open app settings -
    func openAppSettings() {
       guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
       UIApplication.shared.open(settingsURL)
   }
}
