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
    @Published var buyTicketInfo: TicketsFoundModel = TicketsFoundModel(data: DateTicket(origin: "", destination: "", originAirport: "", destinationAirport: "", price: 0, airline: "", flightNumber: "", departureAt: "", returnAt: "", transfers: 0, returnTransfers: 0, duration: 0, duration_to: 0, link: ""))
    @Published var classFlight: ClassFlight = .economy
    @Published var userInfo = UserData.shared
    @Published var isPresented = false
    @Published var dataUser: UserModel = UserModel(firstName: "", lastName: "", email: "", dateOfBirth: .now, urlImage: "", passport: "", country: "")
    init() {
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
        
        $dataUser
            .sink { item in
                self.paymentVM.dataUser = item
            }
            .store(in: &cancellable)
    }

    func updateUserData() {
        Task {
            do {
                let userImage = try await firebaseManager.createUserImageDataDB(imageAccount: userInfo.urlImage, id: uid ?? "")
                await MainActor.run {
                    self.userInfo.urlImage = userImage.absoluteString
                }
                try await firebaseManager.createUserDataDB(firstName: dataUser.firstName , lastName: dataUser.lastName , email: dataUser.email, dateOfBirth: dataUser.dateOfBirth, uid: uid ?? "", urlImage: dataUser.urlImage, passport: dataUser.passport, country: dataUser.country)
                
            } catch {
                print ("error")
            }
        }
    }
}
