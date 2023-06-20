//
//  CustomPassengerAndClassTextField.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 20.06.23.
//

import SwiftUI

struct CustomPassengerAndClassTextField: View {
    //MARK: - Property -
    @Binding var passengerValue: String
    @Binding var classFlightValue: ClassFlight
    @Binding var isPresented: Bool
    var textFieldValue: String
    var textSection: String
    
    let dateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter
    }()
    
    var body: some View {
        ZStack(alignment: .leading) {
            Button() {
                isPresented.toggle()
            } label: {
                HStack {
                    Text("\(passengerValue), \(classFlightValue.rawValue)")
                        .font(.system(size: 16, weight: .medium, design: .default))
                        .frame(maxHeight: 60)
                        .padding(.leading, 16)
                    Spacer()
                }
            }
            .fullScreenCover(isPresented: $isPresented) {
                CreateAccountView()
            }
            .frame(maxWidth: .infinity)
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color(.basicColor), lineWidth: 2)
            }
            .foregroundColor(Color(.textBlackWhiteColor))
            .background(Color(.ticketBackgroundColor))
            .cornerRadius(16)
            
            Text(textSection)
                .foregroundColor(Color(.basicColor))
                .background(Color(.ticketBackgroundColor))
                .font(.system(size: 18, weight: .medium, design: .default))
                .padding(.bottom, 60)
                .padding(.leading, 16)
        }
    }
}
