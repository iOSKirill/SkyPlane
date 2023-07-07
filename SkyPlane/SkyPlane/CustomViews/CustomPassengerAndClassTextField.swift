//
//  CustomPassengerAndClassTextField.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 20.06.23.
//

import SwiftUI

struct CustomPassengerAndClassTextField: View {
    
    //MARK: - Property -
    var passengerValue: String
    var classFlightValue: ClassFlight
    var textFieldValue: String
    var textSection: String
    
    //MARK: - Body -
    var body: some View {
        ZStack(alignment: .leading) {
            HStack {
                Text("\(passengerValue), \(classFlightValue.rawValue)")
                    .font(.system(size: 16, weight: .medium, design: .default))
                    .frame(maxHeight: 60)
                    .padding(.leading, 16)
                Spacer()
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
