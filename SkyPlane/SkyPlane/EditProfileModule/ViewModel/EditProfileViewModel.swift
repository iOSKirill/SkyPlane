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
    @Published var userInfo = UserData.shared
    @Published var isPresented = false
    @Published var isAlert: Bool = false
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

    func updateUserData() {
        Task {
            do {
                guard !userInfo.firstName.isEmpty, !userInfo.lastName.isEmpty, !userInfo.passport.isEmpty, !userInfo.country.isEmpty else { return await MainActor.run { self.errorText = "Fill in the user data" } }
                guard userInfo.passport.isValidPassportNumber() else { return await MainActor.run { self.errorText = "Invalid passport number" } }
                let userImage = try await firebaseManager.createUserImageDataDB(imageAccount: userInfo.urlImage, id: uid ?? "")
                await MainActor.run {
                    self.userInfo.urlImage = userImage.absoluteString
                }
                try await firebaseManager.createUserDataDB(firstName: userInfo.firstName, lastName: userInfo.lastName, email: userInfo.email, dateOfBirth: userInfo.dateOfBirth, uid: uid ?? "", urlImage: userInfo.urlImage, passport: userInfo.passport, country: userInfo.country)
                let data = userInfo.getInfo()
                userInfo.saveInfo(user: data)
                
            } catch {
                await MainActor.run {
                    errorText = error.localizedDescription
                }
            }
        }
    }
}
