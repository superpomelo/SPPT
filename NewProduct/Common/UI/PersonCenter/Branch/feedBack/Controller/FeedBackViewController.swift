//
//  FeedBackViewController.swift
//  NewProduct
//
//  Created by 狍子 on 2021/6/23.
//

import UIKit
class FeedBackViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,FirstFeedBackTableViewCellDelegate  {
    @IBOutlet weak var myTableView: UITableView!
    private  let firstCell = "FirstFeedBackTableViewCell"
    private  let firstCellID = "FirstFeedBackTableViewCellID"
    private  var imgUrl:String?

    var imageDatas = [String : Data]()

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
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
  
        let cell:FirstFeedBackTableViewCell = tableView.dequeueReusableCell(withIdentifier: firstCellID, for: indexPath) as! FirstFeedBackTableViewCell
        cell.delegate = self

            
        return cell
        
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
        let cell = myTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! FirstFeedBackTableViewCell
        cell.feedimageView1.image = image
        cell.addimageView1.isHidden = true
        
    }
 
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    /**点击图片*/
    func CellCollectionAction(cell:FirstFeedBackTableViewCell,indexPath:NSInteger){
        showSelectedPhotoActionSheet()
        
    }
    /**点击提交*/
    func submitAction(cell:FirstFeedBackTableViewCell,para:[String:String]) {
        addAdvis(para: para)
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
        }) { (error) in
            
        }
    }
    
    func addAdvis(para:[String:String]) {
        var paras = [String:String]()
        paras = para
        paras["imgUrl"] = imgUrl
        paras["userId"] = String(UserInfoManager.getUid())


        PersonalRequestData().RequestWithaddAdvis(parameters: paras) { result in
            let hw = HWTransientAlertViewController()
            hw.titileTemp = "建议已成功提交"
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
