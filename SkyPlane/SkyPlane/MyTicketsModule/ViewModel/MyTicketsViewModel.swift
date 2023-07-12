//
//  MyTicketsViewModel.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 1.07.23.
//

import Foundation

final class MyTicketsViewModel: ObservableObject {
    
    //MARK: - Property -
    private var firebaseManager: FirebaseManagerProtocol = FirebaseManager()
    private var uid = UserDefaults.standard.string(forKey: "uid")
    @Published var tickets: [TicketsFoundModel] = []
    @Published var isLoading: Bool = true
    
    //MARK: - Get tickets DB -
    func getTicktes() {
        Task { [weak self] in
            guard let self = self else { return }
            do {
                let arrayTickets = try await firebaseManager.getTicketsDB(id: uid ?? "")
                   await MainActor.run {
                       self.tickets = arrayTickets
                       self.isLoading = false
                   }
            } catch {
                await MainActor.run {
                    print(error)
                }
            }
        }
    }
    
    //MARK: Remove my ticket -
    func removeMyTicket(indexRemove: IndexSet) {
        Task { [weak self] in
            guard let self = self else { return }
            do {
                guard let index = indexRemove.first else { return }
                try await firebaseManager.deleteMyTickets(ticket: tickets[index], id: uid ?? "")
            } catch {
                await MainActor.run {
                    print(error)
                }
            }
        }
    }
}
