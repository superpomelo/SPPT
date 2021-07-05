//
//  FileCenterViewController.swift
//  Dzbz
//
//  Created by 狍子 on 2021/3/16.
//

import UIKit
import QuickLook

class FileCenterViewController: WBQLPreviewController,UITableViewDelegate,UITableViewDataSource {

    
    //MARK: - Life Cycle - 生命周期
    //MARK: - Initalization - 初始化
    //MARK: - SubViews - 子视图
    //MARK: - Button Action - 点击事件
    //MARK: - Utility - 多用途(功能)方法
  private  let path = "http://www.gov.cn/zhengce/pdfFile/2021_PDF.pdf"
    var ListmodelAry = [Any]()


    
    
    weak  var delegate : SecondHomeCenterTableViewCellDelegate?
    private  let firstCell = "FirstFileCenterTableViewCell"
    private  let firstCellID = "FirstFileCenterTableViewCellID"
    private  let secondCell = "SecondFileCenterTableViewCell"
    private  let secondCellID = "SecondFileCenterTableViewCellID"

    var dataArray = [String]()
    
    
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var submitButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.fd_prefersNavigationBarHidden = true

//        let path = Bundle.main.path(forResource:"test_pdf_download", ofType:"pdf")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) { [self] in
        self.submitButton.layer.cornerRadius = 5
        self.tableView1.frame = self.bottomView.bounds
        self.bottomView.addSubview(self.tableView1)
//            self.getCooperationList()

        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.6) { [self] in
        self.getCooperationList()
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    private lazy var tableView1: UITableView = {
        
//        let tableView1 = UITableView(frame: CGRect.zero, style: .plain)
        let tableView1 = UITableView()
        tableView1.dataSource = self
        tableView1.delegate = self
        
        tableView1.separatorStyle = .none
        tableView1.showsVerticalScrollIndicator = false
        tableView1.tag = 710

//        tableView1.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 64, right: 0)
        
        tableView1.register(UINib(nibName: firstCell, bundle: nil), forCellReuseIdentifier: firstCellID)
        tableView1.register(UINib(nibName: secondCell, bundle: nil), forCellReuseIdentifier: secondCellID)

        return tableView1
    }()
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section==0 {
            return 1
        }else{
            return self.ListmodelAry.count
        }
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell:FirstFileCenterTableViewCell = tableView.dequeueReusableCell(withIdentifier: firstCellID, for: indexPath) as! FirstFileCenterTableViewCell


            
            return cell
        }else{
            let cell:SecondFileCenterTableViewCell = tableView.dequeueReusableCell(withIdentifier: secondCellID, for: indexPath) as! SecondFileCenterTableViewCell
            
            cell.reloadData(model: self.ListmodelAry[indexPath.row] as! FileCenterModel)
            return cell
        }

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DQVRWKViewController()
            vc.urlstring = "http://www.expoon.com/26925/"
        vc.hidesBottomBarWhenPushed = true

        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func submitButtonAction(_ sender: Any) {
        let vc = ApplyViewController()
        
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    //MARK: - Network request - 网络请求
    /**商务合作首页数据*/
    private  func getCooperationList() -> Void {
        var para = [String:String]()
        para["userId"] = String.init(UserInfoManager.getUid())
        
//        var resultDic = [String: Any]()
//        resultDic["body"] = "phoneNumber=16870714471&pwd=12345"
        FileRequestDatas().RequestWithgetCooperationList(parameters: para) { (result) in
//            let mo:registerModel = result as! registerModel
//            print(mo.birthday)
            
         
            self.ListmodelAry = [FileCenterModel].deserialize(from: result)! as [Any]
            
            self.tableView1.reloadData()
//            deserialize(from: result["imgList"])
            
//            deserialize(from: data["vrStatistic"] as? NSDictionary)
            
        } failure: { (error) in
            
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
