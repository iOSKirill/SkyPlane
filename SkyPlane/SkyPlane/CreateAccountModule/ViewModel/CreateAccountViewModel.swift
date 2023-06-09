//
//  CreateAccountViewModel.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 9.06.23.
//

import Foundation

final class CreateAccountViewModel: ObservableObject {
    
    //MARK: - Property -
    private var firebaseManager: FirebaseManagerProtocol = FirebaseManager()
    @Published var isPresented = false
    
    //MARK: - Methods -
    func singInWithGoogle() {
        Task { [weak self] in
            guard let self = self else { return }
            let user = try await firebaseManager.singInWithGoogle()
            await MainActor.run {
                self.isPresented = true
            }
        }
    }
}
