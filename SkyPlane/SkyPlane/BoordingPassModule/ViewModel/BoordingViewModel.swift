//
//  BoordingViewModel.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 3.07.23.
//

import Foundation

final class BoordingViewModel: ObservableObject {
    
    //MARK: - Property -
    @Published var ticketInfo = Ticket.shared
    @Published var userInfo = UserData.shared
}
