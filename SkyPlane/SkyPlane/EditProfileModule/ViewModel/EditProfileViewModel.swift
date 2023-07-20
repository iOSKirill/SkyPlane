//
//  EditProfileViewModel.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 1.07.23.
//

import Foundation
import Combine

final class EditProfileViewModel: ObservableObject {
    
    //MARK: - Property -
    private var firebaseManager: FirebaseManagerProtocol = FirebaseManager()
    private var uid = UserDefaults.standard.string(forKey: "uid")
    private var cancellable = Set<AnyCancellable>()
    @Published var paymentVM = PaymentViewModel()
    @Published var buyTicketInfo: TicketsFoundModel
    @Published var classFlight: ClassFlight = .economy
    @Published var editProfileModel: EditProfileModel
    @Published var isPresented = false
    @Published var isAlert: Bool = false
    @Published var updateAlert: Bool = false
    @Published var errorText = "" {
        didSet {
            isAlert = true
        }
    }
    
    init() {
        buyTicketInfo = TicketsFoundModel(data: DateTicket())
        editProfileModel = EditProfileModel(firstName: UserData.shared.firstName,
                                            lastName:  UserData.shared.lastName,
                                            email: UserData.shared.email,
                                            dateOfBirth: UserData.shared.dateOfBirth,
                                            urlImage: UserData.shared.urlImage,
                                            passport:  UserData.shared.passport,
                                            country: UserData.shared.country)
        $buyTicketInfo
            .sink { item in
                self.paymentVM.buyTicketInfo = item
            }
            .store(in: &cancellable)
        
        $classFlight
            .sink { item in
                self.paymentVM.classFlight = item
            }
            .store(in: &cancellable)
    }
    
    deinit {
        cancellable.removeAll()
    }
    
    //MARK: - Update user info DB -
    func updateUserData() {
        Task {
            do {
                guard !editProfileModel.firstName.isEmpty, !editProfileModel.lastName.isEmpty, !editProfileModel.passport.isEmpty, !editProfileModel.country.isEmpty else { return await MainActor.run { self.errorText = "Fill in the user data" } }
                guard editProfileModel.firstName.isValidFirstAndLastName(), editProfileModel.lastName.isValidFirstAndLastName() else {
                    return await MainActor.run {
                        self.errorText = "Invalid first of last name"
                    }
                }
                guard editProfileModel.country.isValidFirstAndLastName() else { return await MainActor.run { self.errorText = "Invalid country" } }
                guard editProfileModel.passport.isValidPassportNumber() else { return await MainActor.run { self.errorText = "Invalid passport number" } }
                try await firebaseManager.createUserDataDB(firstName: editProfileModel.firstName, lastName: editProfileModel.lastName, email: editProfileModel.email, dateOfBirth: editProfileModel.dateOfBirth, uid: uid ?? "", urlImage: editProfileModel.urlImage, passport: editProfileModel.passport, country: editProfileModel.country)
                let data = try await firebaseManager.getUserDataDB(id: uid ?? "")
                UserData.shared.saveInfo(user: data)
                await MainActor.run {
                    updateAlert = true
                }
            } catch {
                await MainActor.run {
                    errorText = error.localizedDescription
                    print(error)
                }
            }
        }
    }
}
