//
//  OnboardingView.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 9.06.23.
//

import SwiftUI

struct OnboardingView: View {
    
    //MARK: - Property -
    @StateObject var vm = OnboardingViewModel()
    
    init() {
        UIScrollView.appearance().bounces = false
    }
    
    //MARK: - Skip onboarding button -
    var skipButton: some View {
        HStack {
            Spacer()
            Button {
                vm.skipButton()
            } label: {
                Text("Skip")
                    .foregroundColor(Color(.textBlackWhiteColor))
                    .padding(16)
            }
        }
    }
    
    //MARK: - TablViw onboarding -
    var tablView: some View {
        TabView(selection: $vm.currentStep) {
            ForEach(Array(vm.onboardingSteps.enumerated()), id: \.element) { item, step in
                VStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 100)
                            .stroke(Color(.silverColor), lineWidth: 20)
                            .frame(maxWidth: 200, maxHeight: 300)
                        
                        Image(step.image)
                            .resizable()
                            .frame(maxWidth: 150, maxHeight: 200)
                    }
                    .padding(.bottom, 32)
                    
                    Text(step.title)
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .bold()
                        .padding(.horizontal, 32)
                    
                    Text(step.description)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 50)
                        .padding(16)
                    
                    Spacer()
                }
                .tag(item)
                .padding(.top, 16)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
    
    //MARK: - PageControl onboarding -
    var pageControl: some View {
        HStack {
            ForEach(Array(vm.onboardingSteps.enumerated()), id: \.element) { item, step in
                if item == vm.currentStep {
                    Rectangle()
                        .frame(width: 20, height: 10)
                        .cornerRadius(10)
                        .foregroundColor(Color(.basicColor))
                } else {
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundColor(Color(.silverColor))
                }
            }
        }
        .padding(.bottom, 24)
    }
    
    //MARK: - Next screen onboarding -
    var nextButton: some View {
        Button {
            vm.nextStepOnButton()
        } label: {
            Text(vm.getNextButtonText())
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(Color(.blackColor))
                .padding(16)
                .frame(maxWidth: .infinity)
                .background(Color(.basicColor))
                .cornerRadius(16)
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
        }
        .fullScreenCover(isPresented: $vm.isPresented) {
            CreateAccountView()
        }
    }
    
    //MARK: - Body -
    var body: some View {
        ZStack {
            Color(.backgroundColor).ignoresSafeArea()
            
            VStack {
                skipButton
                tablView
                pageControl
                nextButton
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
