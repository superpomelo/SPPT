//
//  FirstInfoViewTableViewCell.swift
//  Dzbz
//
//  Created by 狍子 on 2021/3/19.
//

import UIKit

class FirstInfoViewTableViewCell: UITableViewCell {

    @IBOutlet weak var leftLabel: UILabel!
    
    @IBOutlet weak var jiantouImageView: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        userImageView.layer.cornerRadius = userImageView.bounds.size.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func reloadData(model:PersonCenterModel)  {
       
    }
}
