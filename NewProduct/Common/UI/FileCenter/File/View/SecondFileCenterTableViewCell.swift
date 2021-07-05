//
//  SecondFileCenterTableViewCell.swift
//  NewProduct
//
//  Created by 狍子 on 2021/6/22.
//

import UIKit

class SecondFileCenterTableViewCell: UITableViewCell {

    @IBOutlet weak var headLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var miaoshuLabel: UILabel!
    
    @IBOutlet weak var payStatusLabel: UILabel!
    
    @IBOutlet weak var signTimeLabel: UILabel!
    
    @IBOutlet weak var endTimeLabel: UILabel!
    
    @IBOutlet weak var fuZeRenLabel: UILabel!
    @IBOutlet weak var heTongJineLabel: UILabel!
    
    @IBOutlet weak var shouJiLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        bottomView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.07).cgColor
//        bottomView.layer.shadowOffset = CGSize(width: 0, height: 0)
//        bottomView.layer.shadowOpacity = 0.07
//        bottomView.layer.shadowRadius = 6.5
//        // layerFillCode
//        let layer = CALayer()
//        layer.frame = bottomView.bounds
//        layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
//        bottomView.layer.addSublayer(layer)
//        bottomView.layer.cornerRadius = 5;
        
        self.bottomView.layer.shadowColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1.0).cgColor
        self.bottomView.layer.shadowOffset = CGSize(width: 0, height: 0);
        self.bottomView.layer.shadowOpacity = 1
        self.bottomView.layer.shadowRadius = 6
//        self.bottomView.layer.borderWidth = 5
        self.bottomView.layer.borderColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1.0).cgColor
        self.bottomView.layer.cornerRadius = 5
        
    }
    func reloadData(model:FileCenterModel) {
        miaoshuLabel.text = model.describe
        signTimeLabel.text = model.createTime
        fuZeRenLabel.text = model.name
        shouJiLabel.text = model.tel
        endTimeLabel.text = model.completionTime
        heTongJineLabel.text = model.amount
        headLabel.text = model.title
        if model.status == 1 {
            payStatusLabel.text = "待回复"
        }else if model.status == 2 {
            payStatusLabel.text = "进行中"

        }else if model.status == 3 {
            payStatusLabel.text = "已交付"

        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
