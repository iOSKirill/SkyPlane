//
//  CustomSectionTextFieldPassword.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 12.06.23.
//

import SwiftUI

struct CustomSectionTextFieldPassword: View {
    
    //MARK: - Property -
    @Binding var bindingValue: String
    @Binding var secureValue: Bool
    var textSection: String
    var textFieldValue: String
    
    //MARK: - Secure textField
    var secureTextField: some View {
        HStack {
            if secureValue {
                SecureField(textFieldValue, text: $bindingValue)
                    .font(.system(size: 16, weight: .regular, design: .default))
                    .frame(height: 52)
                    .padding(.leading, 16)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color(.silverColor), lineWidth: 1)
                    }
            } else {
                TextField(textFieldValue, text: $bindingValue)
                    .font(.system(size: 16, weight: .regular, design: .default))
                    .frame(height: 52)
                    .padding(.leading, 16)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color(.silverColor), lineWidth: 1)
                    }
            }
            
            Button {
                secureValue.toggle()
            } label: {
                Image(systemName: secureValue ? "eye.slash" : "eye")
                    .resizable()
                    .foregroundColor(.gray)
                    .frame(width: 22, height: 17)
                    .padding(.trailing, 17)
            }
        }
        .foregroundColor(Color(.sectionTextFieldColor))
        .background(Color(.silverColor))
        .cornerRadius(16)
    }
    
    //MARK: - Body -
    var body: some View {
        VStack(alignment: .leading) {
            Text(textSection)
                .foregroundColor(Color(.textBlackWhiteColor))
                .font(.system(size: 16, weight: .medium, design: .default))
                .padding(.vertical, 4)
            secureTextField
        }
    }
}