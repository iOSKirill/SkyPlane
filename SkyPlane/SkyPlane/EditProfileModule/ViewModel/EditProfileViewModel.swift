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
    @Published var firstNameUser: String = ""
    @Published var lastNameUser: String = ""
    @Published var emailUser: String = ""
    @Published var dateOfBirthUser: Date = .now
    @Published var urlImageUser: String = ""
    @Published var passportUser: String = ""
    @Published var countryUser: String = ""
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
    
    //MARK: - Get user data -
    func getUserData() {
        firstNameUser = UserData.shared.firstName
        lastNameUser = UserData.shared.lastName
        emailUser = UserData.shared.email
        dateOfBirthUser = UserData.shared.dateOfBirth
        urlImageUser = UserData.shared.urlImage
        passportUser = UserData.shared.passport
        countryUser = UserData.shared.country
    }
    
    //MARK: - Update user info DB -
    func updateUserData() {
        Task {
            do {
                guard !firstNameUser.isEmpty, !lastNameUser.isEmpty, !passportUser.isEmpty, !countryUser.isEmpty else { return await MainActor.run { self.errorText = "Fill in the user data" } }
                guard firstNameUser.isValidFirstAndLastName(), lastNameUser.isValidFirstAndLastName() else {
                    return await MainActor.run {
                        self.errorText = "Invalid first of last name"
                    }
                }
                guard countryUser.isValidFirstAndLastName() else { return await MainActor.run { self.errorText = "Invalid country" } }
                guard passportUser.isValidPassportNumber() else { return await MainActor.run { self.errorText = "Invalid passport number" } }
                try await firebaseManager.createUserDataDB(firstName: firstNameUser, lastName: lastNameUser, email: emailUser, dateOfBirth: dateOfBirthUser, uid: uid ?? "", urlImage: urlImageUser, passport: passportUser, country: countryUser)
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
