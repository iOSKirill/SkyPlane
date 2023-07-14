//
//  CustomProfileTextField.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 3.07.23.
//

import SwiftUI

struct CustomProfileСardHolderNameTextField: View {
    
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

struct CustomProfileCardNumberTextField: View {
    
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
                    .onChange(of: bindingValue) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        let formatted = stride(from: 0, to: filtered.count, by: 4).map {
                            let start = filtered.index(filtered.startIndex, offsetBy: $0)
                            let end = filtered.index(start, offsetBy: 4, limitedBy: filtered.endIndex) ?? filtered.endIndex
                            return String(filtered[start..<end])
                        }
                        self.bindingValue = formatted.joined(separator: "-")
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

struct CustomProfileСvvNumberTextField: View {
    
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
                    .onChange(of: bindingValue) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered.count > 3 {
                            bindingValue = String(filtered.prefix(3))
                        } else {
                            bindingValue = filtered
                        }
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
