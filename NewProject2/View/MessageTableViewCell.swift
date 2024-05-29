//
//  MessageTableViewCell.swift
//  NewProject2
//
//  Created by Diyorbek Xikmatullayev on 26/05/24.
//

import UIKit
import FirebaseAuth

class MessageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var messageLB: UILabel!
    
    @IBOutlet weak var sendorLB: UILabel!
    
    @IBOutlet weak var youLB: UILabel!
    
    @IBOutlet weak var stackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.layer.cornerRadius = stackView.frame.size.height/3
        stackView.layer.masksToBounds = true
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configure(message: Message) {
        
        if Auth.auth().currentUser?.email == message.sender {
            youLB.isHidden = true
            sendorLB.isHidden = false
        } else {
            youLB.isHidden = false
            sendorLB.isHidden = true
        }
        messageLB.text = message.message
//        sendorLB.text = message.sender
    }
    
}
