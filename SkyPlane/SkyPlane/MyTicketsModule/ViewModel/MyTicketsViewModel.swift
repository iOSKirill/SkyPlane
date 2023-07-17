//
//  MyTicketsViewModel.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 1.07.23.
//

import Foundation
import UserNotifications

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
                let arrayTickets = try await firebaseManager.getTicketsDB(id: uid ?? "")
                   await MainActor.run {
                       self.tickets = arrayTickets
                       self.scheduleNotifications()
                       self.isLoading = false
                       self.filter = .all
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
                let arrayTickets = try await firebaseManager.getTicketsDB(id: uid ?? "")
                   await MainActor.run {
                       self.tickets = arrayTickets.filter { $0.departureDate < Date.now.description }
                       self.isLoading = false
                       self.filter = .pastTrip
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
                let arrayTickets = try await firebaseManager.getTicketsDB(id: uid ?? "")
                   await MainActor.run {
                       self.tickets = arrayTickets.filter { $0.departureDate > Date.now.description }
                       self.isLoading = false
                       self.filter = .upcomingTrip
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
    
    //MARK: - Schedule notification -
    func scheduleNotifications() {
        for flight in tickets {
            let content = UNMutableNotificationContent()
            content.title = "Departure reminder"
            content.body = "Your flight: \(flight.origin) - \(flight.destination), it's leaving soon!\nFlight number: \(flight.flightNumber)\nDeparture time: \(flight.departureDate.formatDateTicket())"
            content.sound = UNNotificationSound.default
            
            let dateTicket = flight.departureDate
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

            if let date = dateFormatter.date(from: dateTicket) {
                let triggerDate = Calendar.current.date(byAdding: .hour, value: -2, to: date)!
                print(triggerDate)
                let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: triggerDate), repeats: false)
                let request = UNNotificationRequest(identifier: "flightReminder\(flight.id)", content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request)
            } else {
                print("Incorrect date string format")
            }
        }
    }
}
