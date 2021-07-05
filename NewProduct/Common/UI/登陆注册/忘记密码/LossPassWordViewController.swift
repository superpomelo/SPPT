//
//  LossPassWordViewController.swift
//  Dzbz
//
//  Created by 狍子 on 2021/3/18.
//

import UIKit

class LossPassWordViewController: UIViewController {
    @IBOutlet weak var oldTF: UITextField!
    @IBOutlet weak var newTF: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var closeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var accountTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initUI()
        self.fd_prefersNavigationBarHidden = true

    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    private  func initUI() -> Void {
        loginButton.layer.cornerRadius = 5
        loginButton.backgroundColor = seDiao_Color1
    }
    @IBAction func backButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        usereditpwd()
    }
    
    /**修改密码*/
    private  func usereditpwd() -> Void {
        var para = [String:String]()
        para["userName"] = self.accountTF.text
        para["pwd"] = self.newTF.text
        para["oldpwd"] = self.oldTF.text
        PersonalRequestData().RequestWithusereditpwd(parameters: para) { [self] result in
            let hw = HWTransientAlertViewController()
            hw.titileTemp = "修改成功"
            self.presentPanModal(hw)
            self.navigationController?.popViewController(animated: true)
            self.navigationController?.popViewController(animated: true)
        } failure: { error in
            let hw = HWTransientAlertViewController()
            hw.titileTemp = "修改失败"
            self.presentPanModal(hw)
            self.navigationController?.popViewController(animated: true)
        }



    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
