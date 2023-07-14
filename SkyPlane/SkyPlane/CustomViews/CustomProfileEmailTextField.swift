//
//  CustomProfileEmailTextField.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 7.07.23.
//

import Foundation
import SwiftUI

struct CustomProfileEmailTextField: View {
    
    //MARK: - Property -
    var textSection: String
    
    //MARK: - Body -
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .leading) {
                HStack {
                    Text(UserData.shared.email)
                        .font(.system(size: 16, weight: .regular, design: .default))
                        .frame(height: 60)
                        .padding(.leading, 16)
                        .foregroundColor(Color(.textBlackWhiteColor))
                        .cornerRadius(16)
                    Spacer()
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color(.basicColor), lineWidth: 2)
                }
                
                Text(textSection)
                    .foregroundColor(Color(.basicColor))
                    .background(Color(.homeBackgroundColor))
                    .font(.system(size: 18, weight: .medium, design: .default))
                    .padding(.bottom, 60)
                    .padding(.leading, 16)
            }
        }
    }
}
