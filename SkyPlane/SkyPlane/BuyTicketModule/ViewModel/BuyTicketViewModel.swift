//
//  BuyTicketViewModel.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 28.06.23.
//

import Foundation
import Combine

final class BuyTicketViewModel: ObservableObject {
    
    //MARK: - Property -
    private var cancellable = Set<AnyCancellable>()
    @Published var editProfileVM = EditProfileViewModel()
    @Published var buyTicketInfo: TicketsFoundModel
    @Published var classFlight: ClassFlight = .economy
    @Published var businessPrice: Int = 0
    
    var imageURL: String {
           return "https://pics.avs.io/100/50/\(buyTicketInfo.icon).png"
    }

    init(buyTicketInfo: TicketsFoundModel) {
        self.buyTicketInfo = buyTicketInfo
        $buyTicketInfo
            .sink { item in
                self.editProfileVM.buyTicketInfo = item
            }
            .store(in: &cancellable)
        
        $classFlight
            .sink { item in
                self.editProfileVM.classFlight = item
            }
            .store(in: &cancellable)
    }
    
    deinit {
        cancellable.removeAll()
    }
}
