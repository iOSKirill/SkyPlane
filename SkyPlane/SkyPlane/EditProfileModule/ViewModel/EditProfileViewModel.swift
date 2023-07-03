//
//  EditProfileViewModel.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 1.07.23.
//

import Foundation

final class EditProfileViewModel: ObservableObject {
    
    //MARK: - Property -
    private var firebaseManager: FirebaseManagerProtocol = FirebaseManager()
    private var uid = UserDefaults.standard.string(forKey: "uid")
    @Published var userInfo = UserData.shared
    @Published var isPresented = false
    
    let dateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter
    }()
    
    func updateUserData() {
        Task {
            do {
                let userImage = try await firebaseManager.createUserImageDataDB(imageAccount: userInfo.urlImage, id: uid ?? "")
                await MainActor.run {
                    self.userInfo.urlImage = userImage.absoluteString
                }
                try await firebaseManager.createUserDataDB(firstName: userInfo.firstName, lastName: userInfo.lastName, email: userInfo.email, dateOfBirth: userInfo.dateOfBirth, uid: uid ?? "", urlImage: userInfo.urlImage, passport: userInfo.passport, country: userInfo.country)
                let data = userInfo.getInfo()
                userInfo.saveInfo(user: data)
            } catch {
                print ("error")
            }
        }
    }
}
