//
//  CustomSectionTextField.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 12.06.23.
//

import SwiftUI

struct CustomSectionTextField: View {
    //MARK: - Property -
    @Binding var bindingValue: String
    var textSection: String
    var textFieldValue: String
    
    //MARK: - Body -
    var body: some View {
        Section(textSection) {
            TextField(textFieldValue, text: $bindingValue)
                .font(.system(size: 16, weight: .regular, design: .default))
                .frame(height: 52)
                .padding(.leading, 16)
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color(.silverColor), lineWidth: 1)
                }
                .foregroundColor(Color(.sectionTextFieldColor))
                .background(Color(.silverColor))
                .cornerRadius(16)
                .padding(.top, 8)
                .autocapitalization(.none)
        }
        .foregroundColor(Color(.textBlackWhiteColor))
        .font(.system(size: 16, weight: .medium, design: .default))
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: -10, trailing: 16))
    }
}

