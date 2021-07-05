//
//  SexView.swift
//  NewProduct
//
//  Created by 狍子 on 2021/7/1.
//

import UIKit
protocol SexViewDelegate:NSObjectProtocol {
    func buttonAction(vi:SexView,tag:String,str:String)

}
class SexView: UIView {
    weak  var delegate : SexViewDelegate?
    var labt : UILabel!
    @IBAction func button1Action(_ sender: UIButton) {
        //1男
        delegate?.buttonAction(vi: self, tag: "1", str: sender.currentTitle!)
    }
    
    @IBAction func button2Action(_ sender: UIButton) {
        //2女
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
