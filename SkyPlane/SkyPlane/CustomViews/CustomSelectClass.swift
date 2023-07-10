//
//  CustomSelectClass.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 29.06.23.
//

import SwiftUI

struct CustomSelectClass: View {
    
    //MARK: - Property -
    @Binding var selectClass: ClassFlight
    var selectClassItem: ClassFlight
    var buyTicketModel: BuyTicketModel
    
    //MARK: - Label select class button -
    var labelSelectClassButton: some View {
        VStack(alignment: .leading) {
            Text(buyTicketModel.selectClassName)
                .font(.system(size: 22, weight: .bold))
                .padding(.leading, 16)
                .foregroundColor(Color(.textBlackWhiteColor))
            
            Text("----------------------------------------------")
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(Color(.textTicketColor))
                .frame(maxWidth: .infinity)
            
            HStack {
                Image(.cabinBag)
                Text("Cabin bag")
                    .font(.system(size: 20, weight: .regular))
                    .foregroundColor(Color(.textBlackWhiteColor))
                Spacer()
                Text(buyTicketModel.cabingBag)
                    .font(.system(size: 20, weight: .regular))
                    .foregroundColor(Color(.textBlackWhiteColor))
            }
            .padding(.horizontal, 16)
            
            HStack {
                Image(.calendarClass)
                Text("Date Change Free")
                    .font(.system(size: 20, weight: .regular))
                    .foregroundColor(Color(.textBlackWhiteColor))
                Spacer()
                Text(buyTicketModel.changeFree)
                    .font(.system(size: 20, weight: .regular))
                    .foregroundColor(Color(.textBlackWhiteColor))
            }
            .padding(.horizontal, 16)
            
            HStack {
                Image(.mealClass)
                Text("Meal")
                    .font(.system(size: 20, weight: .regular))
                    .foregroundColor(Color(.textBlackWhiteColor))
                Spacer()
                Text("Free")
                    .font(.system(size: 20, weight: .regular))
                    .foregroundColor(Color(.textBlackWhiteColor))
            }
            .padding(.horizontal, 16)
            
            HStack {
                Image(.dollarClass)
                Text("Cancellation")
                    .font(.system(size: 20, weight: .regular))
                    .foregroundColor(Color(.textBlackWhiteColor))
                Spacer()
                Text(buyTicketModel.cancellation)
                    .font(.system(size: 20, weight: .regular))
                    .foregroundColor(Color(.textBlackWhiteColor))
            }
            .padding(.horizontal, 16)
        }
        .frame(maxWidth: .infinity, maxHeight: 250)
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(selectClass == selectClassItem ? Color(.basicColor) : Color(.textTicketColor), lineWidth: 3)
        }
    }
    
    //MARK: - Body -
    var body: some View {
        Button {
            selectClass = selectClassItem
        } label: {
            labelSelectClassButton
        }
        .background(Color(.ticketBackgroundColor))
        .cornerRadius(16)
        .padding(.horizontal, 16)
        .frame(width: UIScreen.main.bounds.width)
    }
}
