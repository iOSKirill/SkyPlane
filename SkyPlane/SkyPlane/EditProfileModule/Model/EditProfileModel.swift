//
//  EditProfileModel.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 19.07.23.
//

import Foundation

struct EditProfileModel: Codable {
    var firstName: String
    var lastName: String
    var email: String
    var dateOfBirth: Date
    var urlImage: String
    var passport: String
    var country: String
}
