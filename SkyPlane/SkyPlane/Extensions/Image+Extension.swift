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
    case firstOnboarding = "firstOnboarding"
    case secondOnboarding = "secondOnboarding"
    case thirdOnboarding = "thirdOnboarding"
    case logoSkyPlane = "logoSkyPlane"
    case singInWithGoogle = "singInWithGoogle"
    case logoBlackGreen = "logoBlackGreen"
}

//MARK: - Extension Image -
extension Image {
    
    init(_ assetIdentifier: AssetsImage) {
        self.init(assetIdentifier.rawValue)
    }
}
