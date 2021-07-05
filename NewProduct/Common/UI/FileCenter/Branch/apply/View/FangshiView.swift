//
//  FangshiView.swift
//  NewProduct
//
//  Created by 狍子 on 2021/6/29.
//

import UIKit
protocol FangshiViewDelegate:NSObjectProtocol {
    func buttonAction(vi:FangshiView,tag:String,str:String)

}
class FangshiView: UIView {
    weak  var delegate : FangshiViewDelegate?
    var labt : UILabel!
    @IBAction func button1Action(_ sender: UIButton) {
        delegate?.buttonAction(vi: self, tag: "1", str: sender.currentTitle!)
    }
    
    @IBAction func button2Action(_ sender: UIButton) {
        delegate?.buttonAction(vi: self, tag: "2", str: sender.currentTitle!)

    }
    
    @IBAction func button3Action(_ sender: UIButton) {
        delegate?.buttonAction(vi: self, tag: "3", str: sender.currentTitle!)

    }
    
    @IBAction func button4Action(_ sender: UIButton) {
        delegate?.buttonAction(vi: self, tag: "4", str: sender.currentTitle!)

    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}

// MARK: - How to initialise a UIView Class with a xib file in Swift
extension UIView {
    class func loadFromNibNamed(nibNamed: String, bundle: Bundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
}
