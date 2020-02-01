//
//  Message.swift
//  NewSkype
//
//  Created by Jakub Vodak on 14/01/2020.
//  Copyright © 2020 STRV. All rights reserved.
//

import Foundation
import Firebase

class Message {

    // MARK: Properties

    let key: String
    let text: String
    let date: Date
    let sender: User

    // MARK: Computed Properties

    var dictionary: [String: Any] {
        get {
            return ["message": text,
                    "date": ChatDataController.dateFormatterData.string(from: date),
                    "sender": [
                        "name": sender.name,
                        "gender": sender.gender.rawValue
                    ]]
        }
    }

    // MARK: Object Lifecycle

    init(key: String, text: String, date: Date, sender: User) {
        self.key = key
        self.text = text
        self.date = date
        self.sender = sender
    }

    init?(dict: [String: Any], key: String) {

        if let text = dict["message"] as? String,
            let dateString = dict["date"] as? String,
            let date = ChatDataController.dateFormatterData.date(from: dateString),
            let senderDict = dict["sender"] as? [String: Any],
            let sender = User(dict: senderDict) {

            self.key = key
            self.text = text
            self.date = date
            self.sender = sender
        }
        else {
            return nil
        }
    }
}
