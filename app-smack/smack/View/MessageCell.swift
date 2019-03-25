//
//  MessageCell.swift
//  Smack
//
//  Created by William Bodily on 3/24/19.
//  Copyright © 2019 William Bodily. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var userAvatar: CircleImage!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var messageBodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(message: Message) {
        messageBodyLabel.text = message.messageBody
        userNameLabel.text = message.userName
        userAvatar.image = UIImage(named: message.userAvatar)
        userAvatar.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColor)
        
        guard let isoDate = message.timeStamp else { return }
        let end = isoDate.index(isoDate.endIndex, offsetBy: -5)
        let trimmedIsoDate = String(isoDate[..<end]).appending("Z")
        
        let isoFormatter = ISO8601DateFormatter()
        let chatDate = isoFormatter.date(from: trimmedIsoDate)
        
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "MMM d, h:mm a"
        
        if let finalDate = chatDate {
            let finalDate = newFormatter.string(from: finalDate)
            timeStampLabel.text = finalDate
        }
    }

}
