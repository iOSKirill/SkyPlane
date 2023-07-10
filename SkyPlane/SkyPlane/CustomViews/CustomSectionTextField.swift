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
        VStack(alignment: .leading) {
            Text(textSection)
                .foregroundColor(Color(.textBlackWhiteColor))
                .font(.system(size: 16, weight: .medium, design: .default))
                .padding(.vertical, 4)
            
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
                .autocapitalization(.none)
        }
    }
}
