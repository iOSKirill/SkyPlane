//
//  CustomProfileTextField.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 3.07.23.
//

import SwiftUI

struct CustomProfileTextField: View {
    //MARK: - Property -
    @Binding var bindingValue: String
    var textSection: String
    var textFieldValue: String
    
    //MARK: - Body -
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .leading) {
                TextField(textFieldValue, text: $bindingValue)
                    .font(.system(size: 16, weight: .regular, design: .default))
                    .frame(height: 60)
                    .padding(.leading, 16)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color(.basicColor), lineWidth: 2)
                    }
                    .foregroundColor(Color(.textBlackWhiteColor))
                    .cornerRadius(16)
                
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


