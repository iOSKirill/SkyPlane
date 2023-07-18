//
//  MapView.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 5.07.23.
//

import SwiftUI

struct MapView: View {
    
    //MARK: - Property -
    @StateObject var vm = MapViewModel()
    @State private var keyboardHeight: CGFloat = 0.0
    
    //MARK: - Search button -
    var searchButton: some View {
        Button {
            vm.isSearch.toggle()
            vm.createRoute()
        } label: {
            Text("Search")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(Color(.blackColor))
                .padding(16)
                .frame(maxWidth: .infinity)
                .background(Color(.basicColor))
                .cornerRadius(16)
        }
        .padding(.horizontal, 16)
    }
    
    //MARK: - Search cicle button -
    var searchCicle: some View {
        Button {
            vm.isSearch.toggle()
        } label: {
            Circle()
                .foregroundColor(Color(.basicColor))
                .frame(maxWidth: 60, maxHeight: 60)
                .overlay {
                    Image(.searchTabBar)
                        .resizable()
                        .scaledToFit()
                        .padding()
                }
        }
        .padding(.bottom, 10)
        .padding(.trailing, 16)
    }
    
    //MARK: - Body -
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                MapViewGoogle(viewModel: vm)
                HStack {
                    Spacer()
                    searchCicle
                }
                if vm.isSearch {
                    VStack {
                        VStack {
                            CustomHomeTextField(bindingValue: $vm.origin, textSection: "Origin", textFieldValue: "Enter your origin")
                                .padding(.horizontal, 16)
                            CustomHomeTextField(bindingValue: $vm.destination, textSection: "Destination", textFieldValue: "Enter your destination")
                                .padding(.horizontal, 16)
                            searchButton
                        }
                        .frame(maxWidth: .infinity, maxHeight: 260)
                        .background(Color(.ticketBackgroundColor))
                        .cornerRadius(16)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 10)
                        Spacer()
                        .frame(height: keyboardHeight)
                    }
                    .animation(.easeInOut)
                    .onAppear {
                        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (notification) in
                            let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
                            let keyboardSize = value.cgRectValue.size
                            keyboardHeight = keyboardSize.height - 100
                        }
                        
                        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (_) in
                            keyboardHeight = 0
                        }
                    }
                    .onDisappear {
                        NotificationCenter.default.removeObserver(self)
                    }
                }
            }
        }
        .alert("Error", isPresented: $vm.isAlert) {
            Button("Cancel", role: .cancel) {}
        } message: {
            Text(vm.errorText)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
