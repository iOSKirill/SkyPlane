//
//  PopularFlightViewModel.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 23.06.23.
//

import Foundation
import SwiftUI


final class PopularFlightViewModel: ObservableObject {
    
    //MARK: - Property -
    @Published var popularFlightInfo: [PopularFlightInfoModel] = []
}
