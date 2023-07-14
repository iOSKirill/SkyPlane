//
//  LauncScreenViewModel.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 8.06.23.
//

import Foundation
import SwiftUI
import Network

//MARK: - Enum AppCondition -
enum AppCondition: String {
    case onboardingView
    case createAccountView
    case homeView
}

final class LaunchScreenViewModel: ObservableObject {
    
    //MARK: - Property -
    @AppStorage("appCondition") var appCondition: AppCondition?
    @Published var isPresented = false
    @Published var isLoading = false
    @Published var isOnline = true
    @Published var value = 1
    
    let gradient = AngularGradient(
        gradient: Gradient(colors: [Color.white.opacity(0.3),
                                    Color.white.opacity(1)]),
        center: .center,
        startAngle: .degrees(360),
        endAngle: .degrees(0))
    
    //MARK: - Methods -
    func nextOnboardingView() {
        checkInternetAccess()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            if self.isOnline {
                self.isPresented = true
            }
        }
    }
    
    //MARK: - Loading circle
    func loadingCircle() {
        self.value = 2
        self.isLoading = true
    }
    
    //MARK: - Check internet access -
    func checkInternetAccess() {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "InternetConnectionMonitor")
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isOnline = path.status == .satisfied
            }
        }
    }
}
