//
//  MessageTableViewCell.swift
//  ChatTestTask
//
//  Created by Ruslan Popesku on 5/25/19.
//  Copyright © 2019 Buyper. All rights reserved.
//

import UIKit
import Kingfisher

class MessageTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var photoImageView: UIImageView!
    @IBOutlet private weak var fullNameLabel: UILabel!
    @IBOutlet private weak var receivedTimeLabel: UILabel!
    @IBOutlet private weak var messageTextLabel: UILabel!
    @IBOutlet private weak var roleLabel: UILabel!
    @IBOutlet private weak var livePlaceLabel: UILabel!
    
    func configure(with message: UserChat) {
        if let url = URL(string: message.profileURLString) {
            photoImageView?.setImage(with: url, placeholder: Asset.photoPlaceholder.image)
        }
        fullNameLabel?.text = message.fullName
        receivedTimeLabel?.text = message.receivedDateString
        messageTextLabel?.text = message.lastMessageText
        roleLabel?.text = message.role
        livePlaceLabel?.text = message.currentLocationPlace
    }
    
}
