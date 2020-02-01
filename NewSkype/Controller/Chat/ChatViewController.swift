//
//  ChatViewController.swift
//  NewSkype
//
//  Created by Jakub Vodak on 13/01/2020.
//  Copyright © 2020 STRV. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: SharedViewController, UITableViewDataSource, UITableViewDelegate, ChatDataControllerDelegate {

    // MARK: Properties

    var me: User!
    var dataController: ChatDataController!

    // MARK: Outlets

    @IBOutlet weak var lblText: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // MARK: Object Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        dataController = ChatDataController()
        dataController.delegate = self

        activityIndicator.startAnimating()

        applyAppearance()


//        NotificationCenter.default.addObserver(self, selector: #selector(self.chatDataControllerDidUpdateData), name: Notification.Name("ChatDataControllerDidUpdateData"), object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {

        dataController.startObserving()
    }

    override func viewDidDisappear(_ animated: Bool) {

        dataController.stopObserving()
    }

    deinit {

        print("Now Deinitialized")
    }

    func applyAppearance() {

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
    }

    // MARK: Actions

    @IBAction func closeChat() {

        //dismiss(animated: true, completion: nil)
        navigationController?.popToRootViewController(animated: true)
    }

    @IBAction func sendMessage() {

        if let msgText = lblText.text {

            let message = Message(key: String(), text: msgText, date: Date(), sender: me)

            let trigger = Database.database().reference(withPath: "Messages").childByAutoId()
            trigger.setValue(message.dictionary)

            lblText.text = ""
        }
    }

    func messageAction(message: Message) {

        let menuController = UIAlertController(title: message.sender.name, message: message.text, preferredStyle: .actionSheet)

        let menuOptionRemove = UIAlertAction(title: "Remove", style: .destructive) { (action) in

            self.dataController.removeMessage(message: message)
        }

        let menuOptionClose = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        menuController.addAction(menuOptionRemove)
        menuController.addAction(menuOptionClose)

        present(menuController, animated: true, completion: nil)
    }

    // MARK: Table View

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return dataController.messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let message = dataController.messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell", for: indexPath) as! MessageTableViewCell

        cell.setContent(message: message)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)

        let message = dataController.messages[indexPath.row]
        messageAction(message: message)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        lblText.resignFirstResponder()
    }

    // MARK: Chat Data Controller

    func chatDataControllerDidUpdateData() {

        activityIndicator.stopAnimating()

        tableView.reloadData()
    }

    func chatDataControllerDidFail(description: String) {

        activityIndicator.stopAnimating()
        
        displayError(message: description)
    }
}
