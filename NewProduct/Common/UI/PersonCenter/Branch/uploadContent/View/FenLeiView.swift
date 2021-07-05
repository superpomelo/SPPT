//
//  FenLeiView.swift
//  NewProduct
//
//  Created by 狍子 on 2021/7/2.
//

import UIKit
protocol FenLeiViewDelegate:NSObjectProtocol {
   
    func buttonAction(vi:FenLeiView, tag: String, str:  String)
  
}
class FenLeiView: UIView {
    weak  var delegate : FenLeiViewDelegate?
    var labt : UILabel!

    @IBAction func button1Action(_ sender: UIButton) {
        //
        delegate?.buttonAction(vi: self, tag: "1", str: sender.currentTitle!)
    }
    
    @IBAction func button2Action(_ sender: UIButton) {
        //
        delegate?.buttonAction(vi: self, tag: "2", str: sender.currentTitle!)

    }
    
    @IBAction func button3Action(_ sender: UIButton) {
        //
        delegate?.buttonAction(vi: self, tag: "3", str: sender.currentTitle!)
    }
    
    @IBAction func button4Action(_ sender: UIButton) {
        //
        delegate?.buttonAction(vi: self, tag: "4", str: sender.currentTitle!)

    }
    @IBAction func button5Action(_ sender: UIButton) {
        //
        delegate?.buttonAction(vi: self, tag: "5", str: sender.currentTitle!)
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
