//
//  ContentView.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 8.06.23.
//

import SwiftUI

struct LaunchScreenView: View {
    
    //MARK: - Property -
    @StateObject var vm = LaunchScreenViewModel()
    
    private let gradient = AngularGradient(
        gradient: Gradient(colors: [Color.white.opacity(0.3),
                                    Color.white.opacity(1)]),
        center: .center,
        startAngle: .degrees(360),
        endAngle: .degrees(0))
    
    var body: some View {
        ZStack {
            Color(.basicColor).ignoresSafeArea()
            
            VStack {
                
                Spacer()
                VStack {
                    Image(.logoSkyPlane)
                        .resizable()
                        .frame(maxWidth: 100, maxHeight: 100)
                    
                    Text("SkyPlane")
                        .font(.system(size: 32, weight: .heavy, design: .monospaced))
                        .foregroundColor(.white)
                        .padding(.top, 24)
                }
                Spacer()
                
                //Loading circle
                Circle()
                    .trim(from: 0.1, to: 0.9)
                    .stroke(gradient, style: StrokeStyle(lineWidth: 15, lineCap: .round,
                        lineJoin: .round))
                    .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0))
                    .animation(Animation.linear.repeatForever(autoreverses: false), value: vm.value)
                    .frame(maxWidth: 70, maxHeight: 70)
                    .padding(.bottom, 74.41)
                    .onAppear(perform: vm.loadingCircle)
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
        .onAppear(perform: vm.nextOnboardingView)
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}
