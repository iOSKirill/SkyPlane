//
//  MyTicketsViewModel.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 1.07.23.
//

import Foundation

//MARK: - Enum fiter my tickets -
enum FilterMyTickets: String {
    case all = "All"
    case pastTrip = "Past Trip"
    case upcomingTrip = "Upcoming Trip"
}

final class MyTicketsViewModel: ObservableObject {
    
    //MARK: - Property -
    private var firebaseManager: FirebaseManagerProtocol = FirebaseManager()
    private var uid = UserDefaults.standard.string(forKey: "uid")
    @Published var tickets: [TicketsFoundModel] = []
    @Published var isLoading: Bool = true
    @Published var filter: FilterMyTickets = .all
    
    //MARK: - Get tickets all DB -
    func getAllTicktes() {
        Task { [weak self] in
            guard let self = self else { return }
            do {
                let arrayTickets = try await firebaseManager.getTicketsAllDB(id: uid ?? "")
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
    
    //MARK: - Get tickets past trip DB -
    func getPastTripTicktes() {
        Task { [weak self] in
            guard let self = self else { return }
            do {
                let arrayTickets = try await firebaseManager.getTicketsPastTripDB(id: uid ?? "")
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
    
    //MARK: - Get tickets upcoming trip DB -
    func getUpcomingTripTicktes() {
        Task { [weak self] in
            guard let self = self else { return }
            do {
                let arrayTickets = try await firebaseManager.getTicketsUpcomingTripDB(id: uid ?? "")
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
