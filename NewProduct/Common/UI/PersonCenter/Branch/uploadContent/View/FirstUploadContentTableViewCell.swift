//
//  FirstUploadContentTableViewCell.swift
//  NewProduct
//
//  Created by 狍子 on 2021/6/24.
//

import UIKit
protocol FirstUploadContentTableViewCellDelegate:NSObjectProtocol {
    func submitAction(cell:FirstUploadContentTableViewCell,para:[String:String])
    /**分类*/
    func zuopinfenleiButtonAction(cell:FirstUploadContentTableViewCell)
    /**权限*/
    func quanxianButtonAction(cell:FirstUploadContentTableViewCell)
    /**作品*/
    func zuopingButtonAction(cell:FirstUploadContentTableViewCell)
    /**封面*/
    func fengmianButtonAction(cell:FirstUploadContentTableViewCell)
    
    /**展示方式*/
    func flagButtonAction(cell:FirstUploadContentTableViewCell,tag:String)

}
class FirstUploadContentTableViewCell: UITableViewCell {
    weak  var delegate : FirstUploadContentTableViewCellDelegate?

    @IBOutlet weak var biaotiTF: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var videoIimageView: UIImageView!
    @IBOutlet weak var videoButton: UIButton!
    
    @IBOutlet weak var imgImgeView: UIImageView!
    /**作品分类*/
    @IBOutlet weak var zuopinfenleiLabel: UILabel!
    
    
    @IBOutlet weak var imgButton: UIButton!
    
    @IBOutlet weak var quanxianLabel: UILabel!


    @IBOutlet weak var zuopingImageView: UIImageView!
    
    @IBOutlet weak var zuopingjiahaoImageView: UIImageView!
    @IBOutlet weak var fengmianImageView: UIImageView!
    
    @IBOutlet weak var fengmianjiahaoImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        submitButton.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func videoButtonAction(_ sender: UIButton) {
        if sender.isSelected == true {
            return
        }
        sender.isSelected = true
        videoIimageView.image = UIImage.init(named: "12")
        imgImgeView.image = UIImage.init(named: "13")
        imgButton.isSelected = false
        delegate?.flagButtonAction(cell: self, tag: "2")
    }
    
    @IBAction func imgButtonAction(_ sender: UIButton) {
        if sender.isSelected == true {
            return
        }
        sender.isSelected = true
        videoIimageView.image = UIImage.init(named: "13")
        imgImgeView.image = UIImage.init(named: "12")
        videoButton.isSelected = false
        delegate?.flagButtonAction(cell: self, tag: "1")

    }
    
    /**分类*/
    @IBAction func zuopinfenleiButtonAction(_ sender: UIButton) {
        delegate?.zuopinfenleiButtonAction(cell: self)
    }
    
    /**权限*/
    @IBAction func quanxianButtonAction(_ sender: UIButton) {
        delegate?.quanxianButtonAction(cell: self)
    }
    
    /**作品*/
    @IBAction func zuopingButtonAction(_ sender: UIButton) {
        delegate?.zuopingButtonAction(cell: self)
    }
    
    /**封面*/
    @IBAction func fengmianButtonAction(_ sender: UIButton) {
        delegate?.fengmianButtonAction(cell: self)
    }
    
    @IBAction func submitButtonAction(_ sender: UIButton) {
        var para = [String:String]()
        para["title"] = biaotiTF.text
        para["userId"] = String(UserInfoManager.getUid())
       
        delegate?.submitAction(cell: self, para: para)
    }
    
    
}
