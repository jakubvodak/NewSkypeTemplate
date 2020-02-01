//
//  PrivacyViewController.swift
//  NewSkype
//
//  Created by Jakub Vodak on 15/01/2020.
//  Copyright © 2020 STRV. All rights reserved.
//

import UIKit

class PrivacyViewController: UIViewController {

    //MARK: Object Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: Actions

    @IBAction func closeAction() {
        navigationController?.popViewController(animated: true)
    }
}
