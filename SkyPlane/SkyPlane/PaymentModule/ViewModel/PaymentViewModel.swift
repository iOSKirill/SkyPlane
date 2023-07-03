//
//  PaymentViewModel.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 3.07.23.
//

import Foundation

final class PaymentViewModel: ObservableObject {
    
    //MARK: - Property -
    private var firebaseManager: FirebaseManagerProtocol = FirebaseManager()
    private var uid = UserDefaults.standard.string(forKey: "uid")
    @Published var ticketInfo = Ticket.shared
    @Published var cardNumber: String = ""
    @Published var cardHolderName: String = ""
    @Published var cvv: String = ""
    @Published var date = Date()
    
    let dateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/yy"
        return formatter
    }()
    
    func saveTicket() {
        Task {
            do {
                try await firebaseManager.saveTicket(uid: uid ?? "")
            } catch {
                print("Error Save")
            }
        }
    }
}
