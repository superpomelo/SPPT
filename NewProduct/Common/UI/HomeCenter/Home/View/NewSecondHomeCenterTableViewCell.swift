//
//  NewSecondHomeCenterTableViewCell.swift
//  NewProduct
//
//  Created by 狍子 on 2021/6/21.
//

import UIKit

class NewSecondHomeCenterTableViewCell: UITableViewCell {
    @IBOutlet weak var bbottomView: UIView!
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var zuoPingMLabel: UILabel!
    
    @IBOutlet weak var liuLanShuMLabel: UILabel!
    
    @IBOutlet weak var shouCangShuMLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bottomView.layer.cornerRadius = 5
        
        bgView.layer.shadowColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 0.07).cgColor
        bgView.layer.shadowOffset = CGSize(width: 0, height: 0);
        bgView.layer.shadowOpacity = 1
        bgView.layer.shadowRadius = 6
//        self.bottomView.layer.borderWidth = 5
//        bgView.layer.borderColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1.0).cgColor
//        bgView.layer.cornerRadius = 5
    }
    func reloadData(model:HomeCenterstaticModel) {
        self.liuLanShuMLabel.text = model.visitCount
        self.shouCangShuMLabel.text = model.collectCount
        self.zuoPingMLabel.text = model.vrCount
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
