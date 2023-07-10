//
//  OnboardingViewModel.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 9.06.23.
//

import Foundation
import SwiftUI

final class OnboardingViewModel: ObservableObject {
    
    //MARK: - Property -
    @AppStorage("appCondition", store: .standard) var appCondition: AppCondition = .onboardingView
    @Published var currentStep: Int = 0
    @Published var onboardingSteps = [
        OnboardingStep(id: 0,
                       image: AssetsImage.firstOnboarding.rawValue,
                       title: "Find a relax flight for next trip",
                       description: "Easy to use app for your next flight booking ticket"),
        OnboardingStep(id: 1,
                       image: AssetsImage.secondOnboarding.rawValue,
                       title: "Big world out there, Go Explore",
                       description: "Go to any destination easily by emirates flights"),
        OnboardingStep(id: 2,
                       image: AssetsImage.thirdOnboarding.rawValue,
                       title: "Ready to take \n off the flight",
                       description: "Have a safe journey with emirates flights")
    ]
    
    //MARK: - Methods -
    func nextStepOnButton() {
        if currentStep < onboardingSteps.count - 1 {
            currentStep += 1
        } else {
            appCondition = .createAccountView
        }
    }
    
    //MARK: - Skip button -
    func skipButton() {
        currentStep = onboardingSteps.count - 1
    }
    
    //MARK: - Get next button text -
    func getNextButtonText() -> String {
        currentStep < onboardingSteps.count - 1 ? "Next" : "Get started"
    }
}
