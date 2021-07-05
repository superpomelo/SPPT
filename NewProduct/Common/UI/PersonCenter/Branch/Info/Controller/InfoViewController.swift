//
//  InfoViewController.swift
//  Dzbz
//
//  Created by 狍子 on 2021/3/18.
//

import UIKit

class InfoViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,SexViewDelegate {
    //MARK: - Life Cycle - 生命周期
    //MARK: - Initalization - 初始化
    //MARK: - SubViews - 子视图
    //MARK: - Button Action - 点击事件
    //MARK: - Utility - 多用途(功能)方法
    //MARK: - Network request - 网络请求
    private var helper: YsyPopHelper!

    let titleArray1 = ["昵称"]
    let titleArray2 = ["手机号","性别","机构"]
    var imageDatas = [String : Data]()
    private  var imgUrl:String?

    private  let firstCell = "FirstInfoViewTableViewCell"
    private  let firstCellID = "FirstInfoViewTableViewCellID"
    private  let secondCell = "SecondInfoViewTableViewCell"
    private  let secondCellID = "SecondInfoViewTableViewCellID"
    @IBOutlet weak var myTableView: UITableView!
    private   var model : PersonCenterModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initMyTableView()
        self.fd_prefersNavigationBarHidden = true

    }
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.2) {
            self.userinfo()
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    /**初始化tableview*/
    private func initMyTableView() {
         
        myTableView.delegate   = self
         
        myTableView.dataSource = self
        
        myTableView.bounces = false
//        myTableView.rowHeight = 200
        
       
        myTableView.register(UINib(nibName: firstCell, bundle: nil), forCellReuseIdentifier: firstCellID)
        myTableView.register(UINib(nibName: secondCell, bundle: nil), forCellReuseIdentifier: secondCellID)
        myTableView.tableFooterView = UIView.init()

     }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section==0 {
            return 15
        }else if section == 1{
            return 0
        }
        return 10
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
        let v = UIView.init(frame: CGRect(x: 0, y: 0, width: SCR_W, height: 10))
        v.backgroundColor = RGB_Color(245,245,245,1)
        return v
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
        return 55
        
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else if section == 1 {
            return titleArray1.count
        }else{
            return titleArray2.count

        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        if indexPath.section == 0 {
            
            let cell:FirstInfoViewTableViewCell = tableView.dequeueReusableCell(withIdentifier: firstCellID, for: indexPath) as! FirstInfoViewTableViewCell
            if model != nil {
               
                cell.userImageView.kf.setImage(with: URL(string: (model?.avatar)!))
                                
            }
            return cell
        }else if indexPath.section == 1 {
            let cell:SecondInfoViewTableViewCell = tableView.dequeueReusableCell(withIdentifier: secondCellID, for: indexPath) as! SecondInfoViewTableViewCell
            cell.leftLabel.text = titleArray1[indexPath.row]
            if model != nil {
                cell.reloadData(str: model!.nickname)
            }
            
            return cell
        }else{
            let cell:SecondInfoViewTableViewCell = tableView.dequeueReusableCell(withIdentifier: secondCellID, for: indexPath) as! SecondInfoViewTableViewCell
            cell.leftLabel.text = titleArray2[indexPath.row]
            if indexPath.row == 0 {
                if model != nil {
                    let tel = model?.tel as! String
                    
                    if tel.count == 11 {
                        let pre = tel.prefix(3)
                        let suf = tel.suffix(4)
                        cell.reloadData(str: String.init(format: "%@****%@", pre as CVarArg,suf as CVarArg))
                    }
                }
            }else  if indexPath.row == 1 {
                if model != nil {
                    if model!.gender == 1 {
                        cell.reloadData(str: "男")

                    }else if model?.gender == 2 {
                        cell.reloadData(str: "女")

                    }
                }
            }else{
                if model != nil {
                    cell.reloadData(str: model!.address)
                }
            }
         
            return cell
        }

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                showSelectedPhotoActionSheet()
            }
        }else if indexPath.section == 1 {
            let vc = UsernameViewController()
            vc.toptitle = "设置昵称"
            vc.changestr = "nickName"
            vc.sureBlock = { () -> Void in
                self.userinfo()
            }
            self.present(vc, animated: true) {
                
            }
        }else if indexPath.section == 2 {
            if indexPath.row == 0 {
                let vc = UsernameViewController()
                vc.toptitle = "设置手机号"
                vc.changestr = "tel"
                vc.sureBlock = { () -> Void in
                    self.userinfo()
                }
                self.present(vc, animated: true) {
                    
                }
            }else if indexPath.row == 1 {
//                let vc = UsernameViewController()
//                vc.toptitle = "设置性别"
//                vc.changestr = "gender"
//                vc.sureBlock = { () -> Void in
//                    self.userinfo()
//                }
//                self.present(vc, animated: true) {
//
//                }
                let cell = myTableView.cellForRow(at: IndexPath(row: 1, section: 2)) as! SecondInfoViewTableViewCell
                xingbieAction(lab: cell.textLabel!)
            }else{
                let vc = UsernameViewController()
                vc.toptitle = "设置机构"
                vc.changestr = "address"
                vc.sureBlock = { () -> Void in
                    self.userinfo()
                }
                self.present(vc, animated: true) {
                    
                }
            }
            
//            self.presentPanModal(BirViewController())

        }
    }

    //MARK:- 调起摄像头
    func showSelectedPhotoActionSheet() {
        
        let cameraAction = UIAlertAction(title: NSLocalizedString("拍照", comment: ""), style: .default) { (_) in
            
            if !UIImagePickerController.isSourceTypeAvailable(.camera) {return}
            
            let ipc = UIImagePickerController()
            
            // 照相机
            ipc.sourceType = UIImagePickerController.SourceType.camera
            ipc.delegate = self
            ipc.allowsEditing = true
            self.present(ipc, animated: true, completion: nil)
        }
        
        let libraryAction = UIAlertAction(title: NSLocalizedString("从手机相册选择", comment: ""), style: .default) { (_) in
            let ipc = UIImagePickerController()
            
            // 1.3 设置打开照片相册类型(显示所有相簿)
            ipc.sourceType = UIImagePickerController.SourceType.photoLibrary
            // 4.设置代理
            ipc.delegate = self
            ipc.allowsEditing = true
            self.present(ipc, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: NSLocalizedString("取消", comment: ""), style: .cancel, handler: nil)
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(libraryAction)
        actionSheet.addAction(cancelAction)
        present(actionSheet, animated: true, completion: nil)
    }
    
    //MARK:- 相册控制器代理
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {return}
        //获取图片原尺寸的一半
        let size = CGSize(width: image.size.width/2, height: image.size.height/2)
        //裁剪图片
        let imageTemp = VideoAndPictureCompression.scale(toSize: image, size: size)
        //压缩图片
        let data = VideoAndPictureCompression.imageData(imageTemp)
//        let data = image.jpegData(compressionQuality: 0.5)
        imageDatas["object"] = data
        RequestWithData()
        let cell = myTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! FirstInfoViewTableViewCell
        cell.userImageView.image = image
        cell.jiantouImageView.isHidden = true
        
    }
 
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    /**触发选择*/
    func xingbieAction(lab:UILabel) {
        let fs = Bundle.main.loadNibNamed("SexView", owner: self, options: nil)![0] as! SexView
        fs.delegate = self
        fs.labt = lab
        fs.bounds = CGRect(x: 0, y: 0, width: SCR_W, height: 100)
        helper = YsyPopHelper.init(customView: fs, popStyle: .springFromBottom, dismissStyle: .smoothToBottom, position: .positonBottom)
        helper.superView = self.view
        helper.show()
    }
    /**点击男女代理回调*/
    func buttonAction(vi:SexView,tag:String,str:String) {
        edituser(keyTemp: "gender", valueTemp: String(tag))
        helper.dismiss()
    }

    //MARK: - Network request - 网络请求
    
    /** 上传图片*/
    func RequestWithData()  {
//        let cell = myTableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! SecondUserInformationTableViewCell
//        let para = ["access-key" : "minioadmin",
//                    "secret-key" : "minioadmin",
//                    "bucket-name" : "v2-cloud"
//            ] as [String : String]
        VideoAndImageRequestDatas().RequestWithData(parameters: nil, imageData: imageDatas, success: { (result) in
            self.imgUrl = result as! String
            self.edituser(keyTemp: "avatar", valueTemp: self.imgUrl!)
        }) { (error) in
            
        }
    }
    
    /**修改个人信息*/
    private  func edituser(keyTemp:String,valueTemp:String) -> Void {
        var para = [String:String]()
        para[keyTemp] = valueTemp
        para["userId"] = String(UserInfoManager.getUid())

        PersonalRequestData().RequestWithedituser(parameters: para) { result in
            let hw = HWTransientAlertViewController()
            hw.titileTemp = "修改成功"
            self.presentPanModal(hw)
        } failure: { error in
            let hw = HWTransientAlertViewController()
            hw.titileTemp = "修改失败"
            self.presentPanModal(hw)
        }

    }
    /**获取个人信息*/
    private  func userinfo() -> Void {
        var para = [String:String]()
        para["userId"] = String(UserInfoManager.getUid())
        
        PersonalRequestData().RequestWithuserinfo(parameters: para) { [self] result in
                        
            self.model = result as! PersonCenterModel
                       
            self.myTableView.reloadData()
        } failure: { error in
            
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
