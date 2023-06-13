//
//  CreateAccountModel.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 12.06.23.
//

import Foundation

//MARK: - User model -
struct UserModel: Codable {
    let firstName: String
    let lastName: String
    let email: String
    let dateOfBirth: Date
    let gender: String
    let urlImage: String
}
