//
//  CreateAccountModel.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 12.06.23.
//

import Foundation

struct UserModel: Codable {
    var firstName: String
    var lastName: String
    var email: String
    var dateOfBirth: Date
    var urlImage: String
    var passport: String
    var country: String
}
