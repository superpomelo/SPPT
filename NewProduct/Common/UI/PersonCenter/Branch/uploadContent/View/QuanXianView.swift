//
//  QuanXianView.swift
//  NewProduct
//
//  Created by 狍子 on 2021/7/2.
//

import UIKit

protocol QuanXianViewDelegate:NSObjectProtocol {
   
    func buttonAction(vi:QuanXianView, tag: String, str:  String)
  
}

class QuanXianView: UIView {
    var labt : UILabel!

    weak  var delegate : QuanXianViewDelegate?
    @IBAction func button1Action(_ sender: UIButton) {
        //
        delegate?.buttonAction(vi: self, tag: "1", str: sender.currentTitle!)
    }
    
    @IBAction func button2Action(_ sender: UIButton) {
        //
        delegate?.buttonAction(vi: self, tag: "2", str: sender.currentTitle!)

    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}
