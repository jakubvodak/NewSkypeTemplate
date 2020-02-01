//
//  LoginViewController.swift
//  NewSkype
//
//  Created by Jakub Vodak on 13/01/2020.
//  Copyright © 2020 STRV. All rights reserved.
//

import UIKit

class LoginViewController: SharedViewController {

    //MARK: Properties

    @IBOutlet weak var txtInput: UITextField!
    @IBOutlet weak var segControl: UISegmentedControl!

    //MARK: Object Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    //MARK: Actions

    @IBAction func hideKeyboard() {
        txtInput.resignFirstResponder()
    }

//    @IBAction func loginAction() {
//
//        if let userName = txtInput.text, userName.count >= 2 {
//
//            txtInput.resignFirstResponder()
//
//            let me = User(name: userName)
//            openChat(me: me)
//        }
//        else {
//            displayError(message: "Please specify your name")
//        }
//    }

//    func openChat(me: User) {
//
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//
//        let chatViewController = storyboard.instantiateViewController(withIdentifier: "chatViewController") as! ChatViewController
//
//        chatViewController.me = me
//
//        //present(chatViewController, animated: true, completion: nil)
//        navigationController?.pushViewController(chatViewController, animated: true)
//    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let chatViewController = segue.destination as? ChatViewController {

            let name = txtInput.text!

            let genderIndex = segControl.selectedSegmentIndex
            let gender = UserGender(rawValue: genderIndex) ?? .other

            let me = User(name: name, gender: gender)
            chatViewController.me = me
        }
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {

        if identifier == Constants.Identifiers.ChatViewControllerSegueIdentifier {
            if let userName = txtInput.text, userName.count >= 2 {
                return true
            }
            else {
                displayError(message: "Please specify your name")
                return false
            }
        }
        else {
            return true
        }
    }
}
