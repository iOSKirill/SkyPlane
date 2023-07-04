//
//  CustomSelectClass.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 29.06.23.
//

import SwiftUI

struct BuyTicketModel: Identifiable {
    var id = UUID()
    var selectClassName: String
    var cabingBag: String
    var changeFree: String
    var meal: String
    var cancellation: String
    
    init(classFlight: ClassFlight) {
        switch classFlight {
        case .economy:
            selectClassName = ClassFlight.economy.rawValue
            cabingBag = "4 Kg"
            changeFree = "$200"
            meal = "Free"
            cancellation = "Non-refundable"
        case .business:
            selectClassName = ClassFlight.business.rawValue
            cabingBag = "7 Kg"
            changeFree = "$120"
            meal = "Free"
            cancellation = "Refundable"
        }
    }
}

struct CustomSelectClass: View {
    
    //MARK: - Property -
    @Binding var selectClass: ClassFlight
    var selectClassItem: ClassFlight
    var buyTicketModel: BuyTicketModel
    
    var body: some View {
        Button {
            selectClass = selectClassItem
        } label: {
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
        .background(Color(.ticketBackgroundColor))
        .cornerRadius(16)
        .padding(.horizontal, 16)
        .frame(width: UIScreen.main.bounds.width)
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)

    }
}
