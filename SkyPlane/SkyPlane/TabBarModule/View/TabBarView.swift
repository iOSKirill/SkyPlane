//
//  TabBarView.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 12.06.23.
//

import SwiftUI

struct TabBarView: View {
    
    //MARK: - Property -
    @State var selectedIndex: Int = 2
    @StateObject var vm = TabBarViewModel()
    
    //MARK: - Tabar buttons -
    var tabBarButtons: some View {
        HStack {
            CustomButtonOnTabBar(selectedIndex: $selectedIndex, index: 0, image: .map)
            Spacer(minLength: 12)
            CustomButtonOnTabBar(selectedIndex: $selectedIndex, index: 1, image: .ticketTabBar)
            Spacer(minLength: 12)
            
            //Home Button
            Button {
                selectedIndex = 2
            } label: {
                Image(.homeTabBar)
                    .renderingMode(.template)
                    .font(.system(size: 24,
                                  weight: .regular,
                                  design: .default))
                    .foregroundColor(Color(.tabBarWhiteBackGray))
                    .frame(width: 48, height: 48)
                    .background(Color(.basicColor))
                    .cornerRadius(24)
            }
            .padding(.vertical, 11)
            
            Spacer(minLength: 12)
            CustomButtonOnTabBar(selectedIndex: $selectedIndex, index: 3, image: .weatherTabBar)
            Spacer(minLength: 12)
            CustomButtonOnTabBar(selectedIndex: $selectedIndex, index: 4, image: .profileTabBar)
        }
        .padding(.horizontal, 22)
        .background(Color(.tabBarWhiteBackGray))
    }
    
    //MARK: - Body -
    var body: some View {
        VStack(spacing: 0) {
            switch selectedIndex {
            case 0:
                MapView()
            case 1:
                MyTicketsView()
            case 2:
                HomeView()
            case 3:
                WeatherView()
            case 4:
                ProfileView()
            default:
                Text("View")
            }
            
            ZStack() {
                tabBarButtons
            }
        }
        .task {
            vm.getUserData()
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
