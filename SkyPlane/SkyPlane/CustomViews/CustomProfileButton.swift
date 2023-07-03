//
//  CustomProfileButton.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 1.07.23.
//

import SwiftUI

struct CustomProfileButton<Destination: View>: View  {
    
    //MARK: - Property -
    var view: Destination
    var nameItem: String
    var imageItem: AssetsImage
    
    var body: some View {
        NavigationLink(destination: view) {
            VStack {
                HStack {
                    Image(imageItem)
                        .padding(.leading, 20)
                    Text(nameItem)
                        .font(.system(size: 20, weight: .regular))
                        .foregroundColor(Color(.textBlackWhiteColor))
                        .padding(.leading, 16)
                    Spacer()
                    Image(.arrowProfile)
                        .padding(.trailing, 16)
                }
                Divider()
            }
            .frame(height: 50)
        }
    }
}

