//
//  ContentView.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 8.06.23.
//

import SwiftUI
import Network

struct LaunchScreenView: View {
    
    //MARK: - Property -
    @StateObject var vm = LaunchScreenViewModel()
    
    //MARK: - Logo -
    var logo: some View {
        VStack {
            Image(.logoSkyPlane)
                .resizable()
                .frame(maxWidth: 100, maxHeight: 100)
            
            Text("SkyPlane")
                .font(.system(size: 32, weight: .heavy, design: .monospaced))
                .foregroundColor(.white)
                .padding(.top, 24)
        }
    }
    
    //MARK: - Loding circle -
    var loadingCircle: some View {
        Circle()
            .trim(from: 0.1, to: 0.9)
            .stroke(vm.gradient, style: StrokeStyle(lineWidth: 15, lineCap: .round,
                lineJoin: .round))
            .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0))
            .animation(Animation.linear.repeatForever(autoreverses: false), value: vm.value)
            .frame(maxWidth: 70, maxHeight: 70)
            .padding(.bottom, 74.41)
            .onAppear(perform: vm.loadingCircle)
    }
    
    //MARK: - Body -
    var body: some View {
        ZStack {
            Color(.basicColor).ignoresSafeArea()
            
            VStack {
                if vm.isOnline {
                    Spacer()
                    logo
                    Spacer()
                    loadingCircle
                } else {
                    VStack {
                        Image(.internet)
                        Text("Check your internet connection")
                            .font(.system(size: 22, weight: .bold, design: .default))
                            .multilineTextAlignment(.center)
                        Text("At the moment there is no Internet connection or it is not stable.")
                            .font(.system(size: 20, weight: .regular, design: .default))
                            .multilineTextAlignment(.center)
                            .padding(.top, 10)
                    }
                    .padding(.horizontal, 16)
                    .frame(maxHeight: .infinity)
                }
            }
        }
        .fullScreenCover(isPresented: $vm.isPresented) {
            switch vm.appCondition {
            case .onboardingView:
                OnboardingView()
            case .createAccountView:
                CreateAccountView()
            case .homeView:
                TabBarView()
            case .none:
                OnboardingView()
            }
        }
        .task {
            vm.nextOnboardingView()
        }
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}
