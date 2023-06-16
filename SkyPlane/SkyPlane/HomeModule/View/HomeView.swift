//
//  HomeView.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 14.06.23.
//

import SwiftUI

struct HomeView: View {
    
    //MARK: - Property -
    @StateObject var vm = HomeViewModel()
    
    //MARK: - Body -
    var body: some View {
        Button {
//            vm.getFlightInfo(origin: "MSQ", destination: "MOW", departureDate: "2023-06-17", returnDate: "2023-06-18")
            vm.getPopularFlightInfo(cityName: "MSQ")
        } label: {
            Text("Go")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
