//
//  MessageTableViewCell.swift
//  NewSkype
//
//  Created by Jakub Vodak on 14/01/2020.
//  Copyright © 2020 STRV. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    // MARK: Properties

    var dateFormatterUI: DateFormatter!

    // MARK: Outlets

    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var lblSender: UILabel!
    @IBOutlet weak var lblTime: UILabel!

    // MARK: Object Lifesycle

    override func awakeFromNib() {
        super.awakeFromNib()

        self.dateFormatterUI = DateFormatter()
        self.dateFormatterUI.dateFormat = "hh:mm:ss"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setContent(message: Message) {

        lblText.text = message.text
        lblSender.text = message.sender.name
        lblTime.text = dateFormatterUI.string(from: message.date)

        setGender(gender: message.sender.gender)
    }

    func setGender(gender: UserGender) {

        switch gender {
        case .male: lblSender.textColor = .blue
        case .female: lblSender.textColor = .red
        case .other: lblSender.textColor = .gray
        }
    }

}
