//
//  FirstPersonCenterTableViewCell.swift
//  Dzbz
//
//  Created by 狍子 on 2021/3/16.
//

import UIKit

class FirstPersonCenterTableViewCell: UITableViewCell {

    @IBOutlet weak var twoBottomView: UIView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.size.height/2;
        
        twoBottomView.layer.shadowColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.07).cgColor
        twoBottomView.layer.shadowOffset = CGSize(width: 0, height: 0);
        twoBottomView.layer.shadowOpacity = 1
        twoBottomView.layer.shadowRadius = 6
        twoBottomView.layer.cornerRadius = 5

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
