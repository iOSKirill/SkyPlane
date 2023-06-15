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
        Text("Home")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
