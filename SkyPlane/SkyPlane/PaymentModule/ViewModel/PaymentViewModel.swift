//
//  PaymentViewModel.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 3.07.23.
//

import Foundation
import Combine

final class PaymentViewModel: ObservableObject {
    
    //MARK: - Property -
    private var firebaseManager: FirebaseManagerProtocol = FirebaseManager()
    private var uid = UserDefaults.standard.string(forKey: "uid")
    private var cancellable = Set<AnyCancellable>()
    @Published var isPresented: Bool = false
    @Published var cardNumber: String = ""
    @Published var cardHolderName: String = ""
    @Published var cvv: String = ""
    @Published var date = Date()
    @Published var boordingPassVM = BoordingPassViewModel()
    @Published var buyTicketInfo: TicketsFoundModel = TicketsFoundModel(data: DateTicket(origin: "", destination: "", originAirport: "", destinationAirport: "", price: 0, airline: "", flightNumber: "", departureAt: "", returnAt: "", transfers: 0, returnTransfers: 0, duration: 0, duration_to: 0, link: ""))
    @Published var classFlight: ClassFlight = .economy
    @Published var dataUser: UserModel = UserModel(firstName: "", lastName: "", email: "", dateOfBirth: .now, urlImage: "", passport: "", country: "")
    
    var imageURL: String {
        return "https://pics.avs.io/100/50/\(buyTicketInfo.icon).png"
    }
    
    init() {
        $buyTicketInfo
            .sink { item in
                self.boordingPassVM.buyTicketInfo = item
            }
            .store(in: &cancellable)
        
        $classFlight
            .sink { item in
                self.boordingPassVM.classFlight = item
            }
            .store(in: &cancellable)
        
        $dataUser
            .sink { item in
                self.boordingPassVM.dataUser = item
            }
            .store(in: &cancellable)
    }
    
    func saveTicket() {
        Task {
            do {
                guard let uid = uid else { return }
                switch classFlight {
                case .economy:
                    buyTicketInfo.price = buyTicketInfo.price
                case .business:
                    buyTicketInfo.price *= 2
                }
                try await firebaseManager.saveTicket(uid: uid, origin: buyTicketInfo.origin, destination: buyTicketInfo.destination, price: buyTicketInfo.price, flightNumber: buyTicketInfo.flightNumber, departureDate: buyTicketInfo.departureDate.formatSaveTicket(), returnDate: buyTicketInfo.returnDate.formatSaveTicket(), duration: buyTicketInfo.duration, icon: buyTicketInfo.icon)
                await MainActor.run {
                    self.isPresented.toggle()
                }
            } catch {
                print("Error Save")
            }
        }
    }
}
