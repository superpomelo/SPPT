//
//  NewThirdHomeCenterTableViewCell.swift
//  NewProduct
//
//  Created by 狍子 on 2021/6/21.
//

import UIKit

class NewThirdHomeCenterTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.size.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
