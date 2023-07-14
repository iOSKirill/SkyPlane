//
//  Image+Extension.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 8.06.23.
//

import Foundation
import SwiftUI

//MARK: - Enum AssetsImage -
enum AssetsImage: String {
    //Onboarding Images
    case firstOnboarding = "firstOnboarding"
    case secondOnboarding = "secondOnboarding"
    case thirdOnboarding = "thirdOnboarding"
    
    case logoSkyPlane = "logoSkyPlane"
    case singInWithGoogle = "singInWithGoogle"
    case logoBlackGreen = "logoBlackGreen"
    
    //TabBar Images
    case searchTabBar = "searchTabBar"
    case ticketTabBar = "ticketTabBar"
    case homeTabBar = "homeTabBar"
    case weatherTabBar = "weatherTabBar"
    case profileTabBar = "profileTabBar"
    
    case arrowsHome = "arrowsHome"
    case datePicker = "datePicker"
    case headerScreen = "headerScreen"
    case ticketBackground = "ticketBackground"
    case logoOnTicket = "logoOnTicket"
    case headerTicketsFound = "headerTicketsFound"
    case buyTicketBackground = "buyTicketBackground"
    case headerPlanet = "headerPlanet"
    
    case cabinBag = "cabinBag"
    case calendarClass = "calendarClass"
    case mealClass = "mealClass"
    case dollarClass = "dollarClass"
    
    case headerProfile = "headerProfile"
    case ticketProfile = "ticketProfile"
    case editProfile = "editProfile"
    case privacyPolicyProfile = "privacyPolicyProfile"
    case termsProfile = "termsProfile"
    case arrowProfile = "arrowProfile"
    case changeImage = "changeImage"
    case cards = "cards"
    case headerBookingPass = "headerBookingPass"
    case ticketBoording = "ticketBoording"
    case barcode = "barcode"
    case map = "map"
    case logout = "logout"
    case myTicketError = "myTicketError"
    case internet = "internet"
}

//MARK: - Extension Image -
extension Image {
    
    init(_ assetIdentifier: AssetsImage) {
        self.init(assetIdentifier.rawValue)
    }
}
