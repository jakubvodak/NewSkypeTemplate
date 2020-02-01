//
//  User.swift
//  NewSkype
//
//  Created by Jakub Vodak on 13/01/2020.
//  Copyright © 2020 STRV. All rights reserved.
//

import Foundation

enum UserGender: Int {
    case male = 0
    case female
    case other
}

class User {

    // MARK: Variables

    let name: String
    let gender: UserGender

    // MARK: Object Lifecycle

    init(name: String, gender: UserGender) {

        self.name = name
        self.gender = gender
    }

    init?(dict: [String: Any]) {

        if let name = dict["name"] as? String,
            let genderIndex = dict["gender"] as? Int,
            let gender = UserGender(rawValue: genderIndex) {

            self.name = name
            self.gender = gender
        }
        else {
            return nil
        }
    }
}
