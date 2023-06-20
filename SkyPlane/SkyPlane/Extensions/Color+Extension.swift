//
//  Color+Extension.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 8.06.23.
//

import Foundation
import SwiftUI

//MARK: - Enum AssetsColor -
enum AssetsColor: String {
    case backgroundColor = "backgroundColor"
    case basicColor = "basicColor"
    case blackColor = "blackColor"
    case silverColor = "silverColor"
    case textBlackWhiteColor = "textBlackWhiteColor"
    case sectionTextFieldColor = "sectionTextFieldColor"
    case textSilverWhite = "textSilverWhite"
    case tabBarWhiteBackGray = "tabBarWhiteBackGray"
    case tabBarWhiteGray = "tabBarWhiteGray"
    case homeBackgroundColor = "homeBackgroundColor"
    case ticketBackgroundColor = "ticketBackgroundColor"
}

//MARK: - Extension Color -
extension Color {
    init(_ assetIdentifier: AssetsColor) {
        self.init(assetIdentifier.rawValue)
    }
}
