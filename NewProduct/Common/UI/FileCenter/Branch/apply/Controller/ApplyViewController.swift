//
//  ApplyViewController.swift
//  NewProduct
//
//  Created by 狍子 on 2021/6/23.
//

import UIKit

class ApplyViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,FirstApplyTableViewCellDelegate,FangshiViewDelegate  {

    var cooperateTypeTemp : String = "1"

    private var helper: YsyPopHelper!
    @IBOutlet weak var myTableView: UITableView!
    private  let firstCell = "FirstApplyTableViewCell"
    private  let firstCellID = "FirstApplyTableViewCellID"
    //MARK: - Life Cycle - 生命周期
    //MARK: - Initalization - 初始化
    //MARK: - SubViews - 子视图
    //MARK: - Button Action - 点击事件
    //MARK: - Utility - 多用途(功能)方法
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.fd_prefersNavigationBarHidden = true

        inittableview()
        
    }

    private func inittableview() {
        
//        let tableView1 = UITableView(frame: CGRect.zero, style: .plain)
//        let tableView1 = UITableView()
        myTableView.dataSource = self
        myTableView.delegate = self
//
//        tableView1.separatorStyle = .none
//        tableView1.showsVerticalScrollIndicator = false
//        tableView1.tag = 710

//        tableView1.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 64, right: 0)
        
        myTableView.register(UINib(nibName: firstCell, bundle: nil), forCellReuseIdentifier: firstCellID)
      

    }
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 800
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
        let cell:FirstApplyTableViewCell = tableView.dequeueReusableCell(withIdentifier: firstCellID, for: indexPath) as! FirstApplyTableViewCell

        cell.delegate = self
            
        return cell
        
    }

    @IBAction func backButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    /**提交*/
    func submitAction(cell:FirstApplyTableViewCell,para:[String:String]) {
        addCooperation(para: para)
    }
    /**触发选择*/
    func shangmenleixingAction(lab:UILabel) {
        let fs = Bundle.main.loadNibNamed("FangshiView", owner: self, options: nil)![0] as! FangshiView
        fs.delegate = self
        fs.labt = lab
        fs.bounds = CGRect(x: 0, y: 0, width: SCR_W, height: 200)
        helper = YsyPopHelper.init(customView: fs, popStyle: .springFromBottom, dismissStyle: .smoothToBottom, position: .positonBottom)
        helper.superView = self.view
        helper.show()
    }

    /**选择合作方式*/
   
    func buttonAction(vi: FangshiView, tag: String, str: String) {
        helper.dismiss()
        vi.labt.text = str
        cooperateTypeTemp = tag

    }
    //MARK: - Network request - 网络请求
    func addCooperation(para:[String:String]) {
        var paras = [String:String]()
        paras = para
        paras["cooperateType"] = cooperateTypeTemp
        FileRequestDatas().RequestWithaddCooperation(parameters: paras) { result in
            let hw = HWTransientAlertViewController()
            hw.titileTemp = "申请已成功提交"
            self.presentPanModal(hw)
            self.navigationController?.popViewController(animated: true)

        } failure: { error in
            let hw = HWTransientAlertViewController()
            hw.titileTemp = "未知错误"
            self.presentPanModal(hw)
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
