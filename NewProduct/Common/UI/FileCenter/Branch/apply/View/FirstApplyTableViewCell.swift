//
//  FirstApplyTableViewCell.swift
//  NewProduct
//
//  Created by 狍子 on 2021/6/23.
//

import UIKit
protocol FirstApplyTableViewCellDelegate:NSObjectProtocol {
    func submitAction(cell:FirstApplyTableViewCell,para:[String:String])
    func shangmenleixingAction(lab:UILabel)

}
class FirstApplyTableViewCell: UITableViewCell {
    weak  var delegate : FirstApplyTableViewCellDelegate?
    /**描述*/
    @IBOutlet weak var miaoshuTF: UITextField!
    /**机构名称*/
    @IBOutlet weak var jigouTF: UITextField!
    /**合作方式*/
    @IBOutlet weak var hezuoLable: UILabel!
    /**联系人*/
    @IBOutlet weak var lianxirenTF: UITextField!
    /**电话*/
    @IBOutlet weak var dianhuaTF: UITextField!
    /**需求详情描述*/
    @IBOutlet weak var xuqiuxiangqingTextView: UITextView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var videoIimageView: UIImageView!
    @IBOutlet weak var videoButton: UIButton!
    
    @IBOutlet weak var imgImgeView: UIImageView!
    
    @IBOutlet weak var imgButton: UIButton!
    //合作方式 1：仅拍摄 2：拍摄并部署 3：全套解决方案；4：仅申请部署空间
    var cooperateType : String = "1"
    //拍摄类型 1：全景视屏 2：全景图片
    var vrType : Int = 1

    
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
        vrType = 1
        sender.isSelected = true
        videoIimageView.image = UIImage.init(named: "12")
        imgImgeView.image = UIImage.init(named: "13")
        imgButton.isSelected = false
        
    }
    @IBAction func imgButtonAction(_ sender: UIButton) {
        if sender.isSelected == true {
            return
        }
        vrType = 2

        sender.isSelected = true
        videoIimageView.image = UIImage.init(named: "13")
        imgImgeView.image = UIImage.init(named: "12")
        videoButton.isSelected = false


    }
    
    @IBAction func shangmenleixingButtonAction(_ sender: Any) {
        delegate?.shangmenleixingAction(lab: hezuoLable)
    }
    
    @IBAction func submitButtonAction(_ sender: Any) {
        var para = [String:String]()
        para["title"] = miaoshuTF.text
        para["userId"] = String.init(UserInfoManager.getUid())
        para["company"] = jigouTF.text
        para["name"] = lianxirenTF.text
        para["tel"] = dianhuaTF.text
        para["describes"] = xuqiuxiangqingTextView.text
        para["cooperateType"] = cooperateType
        para["vrType"] =  String(vrType)
      
        delegate?.submitAction(cell: self, para: para)
    }
}
