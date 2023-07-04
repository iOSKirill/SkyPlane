//
//  TabBarViewModel.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 4.07.23.
//

import Foundation
import Combine

final class TabBarViewModel: ObservableObject {
    
    private var firebaseManager: FirebaseManagerProtocol = FirebaseManager()
    private var uid = UserDefaults.standard.string(forKey: "uid")
    private var cancellable = Set<AnyCancellable>()
    @Published var dataUser: UserModel = UserModel(firstName: "", lastName: "", email: "", dateOfBirth: .now, urlImage: "", passport: "", country: "")
    @Published var profileVM = ProfileViewModel()
    @Published var homeVM = HomeViewModel()
    
    init() {
        $dataUser
            .sink { item in
                self.profileVM.dataUser = item
                self.homeVM.dataUser = item
            }
            .store(in: &cancellable)
    }
    
    func getUserData() {
        Task {
            do {
                let data = try await firebaseManager.getUserDataDB(id: uid ?? "")
                await MainActor.run {
                    dataUser = UserModel(firstName: data.firstName, lastName: data.lastName, email: data.email, dateOfBirth: data.dateOfBirth, urlImage: data.urlImage, passport: data.passport, country: data.country)
                }
            } catch {
                print ("error")
            }
        }
    }
}
