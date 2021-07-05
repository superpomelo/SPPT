//
//  FirstFeedBackTableViewCell.swift
//  NewProduct
//
//  Created by 狍子 on 2021/6/23.
//

import UIKit
protocol FirstFeedBackTableViewCellDelegate:NSObjectProtocol {
    func CellCollectionAction(cell:FirstFeedBackTableViewCell,indexPath:NSInteger)
    
    func submitAction(cell:FirstFeedBackTableViewCell,para:[String:String])
}
class FirstFeedBackTableViewCell: UITableViewCell {
    weak  var delegate : FirstFeedBackTableViewCellDelegate?

    @IBOutlet weak var feedimageView1: UIImageView!
    
    @IBOutlet weak var addimageView1: UIImageView!
    
    @IBOutlet weak var feedimageView2: UIImageView!
    
    @IBOutlet weak var addimageView2: UIImageView!
    
    @IBOutlet weak var feedImgeView3: UIImageView!
    
    
    @IBOutlet weak var dianhuaTF: UITextField!
    
    @IBOutlet weak var miaoshuTextView: UITextView!
    @IBOutlet weak var bottomView1: UIView!
    
    @IBOutlet weak var bottomView2: UIView!
    
    @IBOutlet weak var bottomView3: UIView!
    
    @IBOutlet weak var addImageView3: UIImageView!
    @IBOutlet weak var submitButtton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bottomView2.isHidden = true
        bottomView3.isHidden = true
        submitButtton.layer.cornerRadius = 5
    }

    
    @IBAction func addbutton1(_ sender: Any) {
        delegate?.CellCollectionAction(cell: self, indexPath: 1)
    }
    
    @IBAction func addbutton2(_ sender: Any) {
    }
    
    @IBAction func addbutton3(_ sender: Any) {
    }
    
    @IBAction func submitButtonAction(_ sender: Any) {
        let para = ["title" : dianhuaTF.text,
                    "describes" : miaoshuTextView.text
            ] as! [String : String]
        delegate?.submitAction(cell: self, para: para)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
