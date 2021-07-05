//
//  PersonCenterViewController.swift
//  Dzbz
//
//  Created by 狍子 on 2021/3/16.
//

import UIKit
import Kingfisher

class PersonCenterViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    //MARK: - Life Cycle - 生命周期
    //MARK: - Initalization - 初始化
    //MARK: - SubViews - 子视图
    //MARK: - Button Action - 点击事件
    //MARK: - Utility - 多用途(功能)方法
    //MARK: - Network request - 网络请求
    let titleArray1 = ["个人信息","作品管理","合作协议","帮助中心","意见反馈"]
    let imgArray = ["5","6","7","8","9"]

    let titleArray2 = ["我的设置"]
    let imgArray2 = ["10"]

    var imageDatas = [String : Data]()
    private   var model : PersonCenterModel?
    private  let firstCell = "FirstPersonCenterTableViewCell"
    private  let firstCellID = "FirstPersonCenterTableViewCellID"
    private  let secondCell = "SecondPersonCenterTableViewCell"
    private  let secondCellID = "SecondPersonCenterTableViewCellID"
    @IBOutlet weak var myTableView: UITableView!

    @IBOutlet weak var toplayoutconstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initMyTableView()
        self.fd_prefersNavigationBarHidden = true
        if IsIphoneX.isIphoneX() == false {
            self.toplayoutconstraint.constant = -20.0
        }else{
            self.toplayoutconstraint.constant = -48.0

        }

    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.2) {
            self.userinfo()
            
        }
    }
    /**初始化tableview*/
    private func initMyTableView() {
         
        myTableView.delegate   = self
         
        myTableView.dataSource = self
        
        myTableView.bounces = false
//        myTableView.rowHeight = 200
//        myTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        myTableView.register(UINib(nibName: firstCell, bundle: nil), forCellReuseIdentifier: firstCellID)
        
        myTableView.register(UINib(nibName: secondCell, bundle: nil), forCellReuseIdentifier: secondCellID)
        myTableView.tableFooterView = UIView.init()

     }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section==0 {
            return 0
        }
        return 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
        let v = UIView.init(frame: CGRect(x: 0, y: 0, width: SCR_W, height: 10))
        v.backgroundColor = RGB_Color(245,245,245,1)
        return v
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 250
        }else{

            return 55
        }
        
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
            let cell:FirstPersonCenterTableViewCell = tableView.dequeueReusableCell(withIdentifier: firstCellID, for: indexPath) as! FirstPersonCenterTableViewCell
            if model != nil {
               
                cell.avatarImageView.kf.setImage(with: URL(string: (model?.avatar)!))
                
                cell.userNameLabel.text = model?.nickname
                
            }
            return cell
        }else if indexPath.section == 1 {
            let cell:SecondPersonCenterTableViewCell = tableView.dequeueReusableCell(withIdentifier: secondCellID, for: indexPath) as! SecondPersonCenterTableViewCell
            cell.leftLabel.text = titleArray1[indexPath.row]
            cell.leftImageView.image = UIImage.init(named: imgArray[indexPath.row])
            
            return cell
        }else{
            let cell:SecondPersonCenterTableViewCell = tableView.dequeueReusableCell(withIdentifier: secondCellID, for: indexPath) as! SecondPersonCenterTableViewCell
            cell.leftLabel.text = titleArray2[indexPath.row]
            cell.leftImageView.image = UIImage.init(named: imgArray2[indexPath.row])
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section==0 {
            DispatchQueue.main.async {
                self.showSelectedPhotoActionSheet()  //调起
            }
        }
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                let vc = InfoViewController()
                vc.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(vc, animated: true)
            }
            if indexPath.row == 1 {
                let vc = MyContentViewController()
                vc.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(vc, animated: true)
            }
            if indexPath.row == 4 {
                let vc = FeedBackViewController()
                vc.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(vc, animated: true)
            }
        }
        if indexPath.section == 2 {
            let vc = SettingViewController()
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        }

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
        imageDatas["avatar"] = data
//        requestusereditprofile()
        
    }
 
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
    
    //MARK:- 调起选择
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
    
    
 
    //MARK: - Network request - 网络请求

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
