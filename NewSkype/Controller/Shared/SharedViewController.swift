//
//  SharedViewController.swift
//  NewSkype
//
//  Created by Jakub Vodak on 15/01/2020.
//  Copyright © 2020 STRV. All rights reserved.
//

import UIKit

class SharedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func displayError(message: String) {

        let errorMessage = UIAlertController(title: "Error", message: message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)

        errorMessage.addAction(okAction)
        present(errorMessage, animated: true, completion: nil)
    }
}
