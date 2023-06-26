//
//  CustomDatePickerTextField.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 19.06.23.
//

import SwiftUI

struct CustomDatePickerTextField: View {
    
    //MARK: - Property -
    @Binding var selectedDate: Date
    @Binding var showDatePicker: DatePickerShow
    var showDatePickerItem: DatePickerShow
    var textSection: String
    
    let dateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter
    }()
    
    var body: some View {
        ZStack(alignment: .leading) {
            HStack {
                Button {
                    showDatePicker = showDatePickerItem
                } label: {
                    Image(.datePicker)
                        .overlay {
                            DatePicker("", selection: $selectedDate, displayedComponents: [.date])
                                .blendMode(.destinationOver)
                        }

                }
                .padding(.leading, 16)
       
                Text("\(selectedDate, formatter: dateFormat)")
                    .font(.system(size: 16, weight: .medium, design: .default))
                    .frame(height: 60)
                
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

