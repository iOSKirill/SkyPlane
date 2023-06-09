//
//  LauncScreenViewModel.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 8.06.23.
//

import Foundation
import SwiftUI

final class LaunchScreenViewModel: ObservableObject {
    
    //MARK: - Property -
    @Published var isPresented = false
    @Published var isLoading = false
    @Published var value = 1
    
    //MARK: - Methods -
    func nextOnboardingView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.isPresented = true
        }
    }
    
    func loadingCircle() {
        self.value = 2
        self.isLoading = true
    }
}
