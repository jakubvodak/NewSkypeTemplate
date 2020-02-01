//
//  ChatDataController.swift
//  NewSkype
//
//  Created by Jakub Vodak on 15/01/2020.
//  Copyright © 2020 STRV. All rights reserved.
//

import Foundation
import Firebase

protocol ChatDataControllerDelegate: NSObjectProtocol {
    func chatDataControllerDidUpdateData()
    func chatDataControllerDidFail(description: String)
}

class ChatDataController {

    //MARK: Properties

    private(set) var messages = [Message]()
    private var database: DatabaseReference?

    static var dateFormatterData = DateFormatter()

    //MARK: Delegate

    weak var delegate: ChatDataControllerDelegate?

    func didUpdate1() {

        if let d = delegate {
            d.chatDataControllerDidUpdateData()
        }
        else {
            assert(true, "Delegate implementation missing!")
        }
    }

    func didUpdate2() {
        //TODO: DidUpdateBlock
    }

    func didUpdate3() {
        NotificationCenter.default.post(name: Notification.Name("ChatDataControllerDidUpdateData"), object: nil)
    }

    func didFail(description: String) {

        if let d = delegate {
            d.chatDataControllerDidFail(description: description)
        }
        else {
            assert(true, "Delegate implementation missing!")
        }
    }

    //MARK: Object Lifecycle

    init() {

        database = Database.database().reference(withPath: "Messages")

        ChatDataController.dateFormatterData = DateFormatter()
        ChatDataController.dateFormatterData.timeZone = TimeZone(abbreviation: "GMT")
        ChatDataController.dateFormatterData.locale = NSLocale.current
        ChatDataController.dateFormatterData.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    }

    // MARK: Firebase

    func startObserving() {

        database?.observe(DataEventType.childAdded, with: { (snapshot) in
            self.parseData(snapshot)
        }, withCancel: { (error) in
            self.didFail(description: error.localizedDescription)
        })

        database?.observe(DataEventType.childRemoved, with: { (snapshot) in

            self.messages = self.messages.filter{ $0.key != snapshot.key }
            self.didUpdate1()
        })
    }

    func stopObserving() {

        database?.removeAllObservers()
    }

    func removeMessage(message: Message) {

        let ref = Database.database().reference(withPath: "Messages").child(message.key)
        
        ref.removeValue()
    }
}

// MARK: Extensions

private extension ChatDataController {

    func parseData(_ snapshot: DataSnapshot) {

        if let dict = snapshot.value as? [String: Any],
            let message = Message(dict: dict, key: snapshot.key) {

            messages.insert(message, at: 0)
            didUpdate1()
        }
    }
}
