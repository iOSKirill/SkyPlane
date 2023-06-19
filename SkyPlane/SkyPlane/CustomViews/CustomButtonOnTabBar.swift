//
//  CustomButtonOnTabBar.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 14.06.23.
//

import SwiftUI

struct CustomButtonOnTabBar: View {
    
    //MARK: - Property -
    @Binding var selectedIndex: Int
    let index: Int
    let image: AssetsImage
    
    //MARK: - Body -
    var body: some View {
        Button {
            selectedIndex = index
        } label: {
            Image(image)
                .renderingMode(.template)
        }
        .foregroundColor(selectedIndex == index ? Color(.basicColor) : Color(.tabBarWhiteGray))
    }
}


