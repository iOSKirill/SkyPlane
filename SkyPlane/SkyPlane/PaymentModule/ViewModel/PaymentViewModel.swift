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
    @Published var buyTicketInfo: TicketsFoundModel
    @Published var classFlight: ClassFlight = .economy
    @Published var isAlert: Bool = false
    @Published var isPresentedCancel: Bool = false
    @Published var errorText = "" {
        didSet {
            isAlert = true
        }
    }
    
    var imageURL: String {
        return "https://pics.avs.io/100/50/\(buyTicketInfo.icon).png"
    }
    
    init() {
        buyTicketInfo = TicketsFoundModel(data: DateTicket())
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
    }
    
    deinit {
        cancellable.removeAll()
    }
    
    //MARK: - Sace ticket DB -
    func saveTicket() {
        Task {
            do {
                guard let uid = uid else { return }
                guard !cardNumber.isEmpty, !cardHolderName.isEmpty, !cvv.isEmpty else { return await MainActor.run { self.errorText = "Fill in the card data" } }
                guard cardNumber.count == 16, cvv.count == 3 else { return await MainActor.run { self.errorText = "Invalid format" } }
                guard cardNumber.isValidCardNumber() else { return await MainActor.run { self.errorText = "Invalid card number" } }
                guard cvv.isValidCvvNumber() else { return await MainActor.run { self.errorText = "Invalid cvv number" } }
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
                errorText = error.localizedDescription
            }
        }
    }
}
