//
//  UploadContentViewController.swift
//  NewProduct
//
//  Created by 狍子 on 2021/6/24.
//

import UIKit

class UploadContentViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,FenLeiViewDelegate,FirstUploadContentTableViewCellDelegate,QuanXianViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
  
    
    private var helper: YsyPopHelper!
    private var quanxianhelper: YsyPopHelper!

    @IBOutlet weak var myTableView: UITableView!
    private  let firstCell = "FirstUploadContentTableViewCell"
    private  let firstCellID = "FirstUploadContentTableViewCellID"
    /**标识 1：VR全景图 2:VR全景视屏  自己添加的<3:封面> */
    var flag : String = "2"
    /**类别ID*/
    var categoryId : String = "1"
    /**是否公开 1：所有人可见 0：私人可见*/
    var isPublic : String = "1"
    var imageDatas = [String : Data]()
    /**封面图地址*/
    private  var imgUrl:String?
    /**视屏网址*/
    private  var url:String?
    
    /**图片类型1-作品图，2-封面图*/
    private  var imgtype:String = "1"

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
        return 1200
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
        let cell:FirstUploadContentTableViewCell = tableView.dequeueReusableCell(withIdentifier: firstCellID, for: indexPath) as! FirstUploadContentTableViewCell
        cell.delegate = self

            
        return cell
        
    }

    @IBAction func backButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    /**触发选择*/
    func fenleiAction(lab:UILabel) {
        let fs = Bundle.main.loadNibNamed("FenLeiView", owner: self, options: nil)![0] as! FenLeiView
        fs.delegate = self
        fs.labt = lab
        var h = 250
        
        if IsIphoneX.isIphoneX() {
            h = 300
        }
        fs.bounds = CGRect(x: 0, y: 0, width: Int(SCR_W), height: h)
        helper = YsyPopHelper.init(customView: fs, popStyle: .springFromBottom, dismissStyle: .smoothToBottom, position: .positonBottom)
        helper.superView = self.view
        helper.show()
    }
    /**分类选择代理*/
    func buttonAction(vi:FenLeiView, tag: String, str:  String) {
        vi.labt.text = str
        self.categoryId = tag
        helper.dismiss()
    }
    /**提交*/
    func submitAction(cell:FirstUploadContentTableViewCell,para:[String:String]){
        useraddVr(para: para)
    }
    /**分类*/
    func zuopinfenleiButtonAction(cell:FirstUploadContentTableViewCell) {
        fenleiAction(lab: cell.zuopinfenleiLabel)
    }
    /**权限*/
    func quanxianButtonAction(cell:FirstUploadContentTableViewCell) {
        quanxianAction(lab: cell.quanxianLabel)
        
    }
    /**作品*/
    func zuopingButtonAction(cell:FirstUploadContentTableViewCell) {
        self.imgtype = "1"
        showSelectedPhotoActionSheet()
    }
    /**封面*/
    func fengmianButtonAction(cell:FirstUploadContentTableViewCell) {
        self.imgtype = "2"
        self.flag = "3"
        showSelectedPhotoActionSheet()
    }

    
    /**展示方式*/
    func flagButtonAction(cell:FirstUploadContentTableViewCell,tag:String){
       //tag 标识 1：VR全景图 2:VR全景视屏
        self.flag = tag
    }
    /**触发选择*/
    func quanxianAction(lab:UILabel) {
        let fs = Bundle.main.loadNibNamed("QuanXianView", owner: self, options: nil)![0] as! QuanXianView
        fs.delegate = self
        fs.labt = lab
        var h = 100
        
        if IsIphoneX.isIphoneX() {
            h = 150
        }
        fs.bounds = CGRect(x: 0, y: 0, width: Int(SCR_W), height: h)
        quanxianhelper = YsyPopHelper.init(customView: fs, popStyle: .springFromBottom, dismissStyle: .smoothToBottom, position: .positonBottom)
        quanxianhelper.superView = self.view
        quanxianhelper.show()
    }
    
    /**权限选择代理*/
    func buttonAction(vi:QuanXianView, tag: String, str:  String) {
        vi.labt.text = str
        self.isPublic = tag
        quanxianhelper.dismiss()
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
            if self.flag == "1"||self.imgtype == "2" {
              //全景图
                ipc.mediaTypes = ["public.image"]
            }else if self.flag == "2" {
              //全景视频
                ipc.mediaTypes = ["public.movie"]
            }
            
//            if self.imgtype == "2" {
//                // 封面图
//                ipc.mediaTypes = ["public.image"]
//            }
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

        let mediaType = info[UIImagePickerController.InfoKey.mediaType]
        picker.dismiss(animated: true, completion: nil)
        if mediaType as! String == "public.movie" {
            let url = info[UIImagePickerController.InfoKey.mediaURL]
            let cell = myTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! FirstUploadContentTableViewCell
            let data = NSData.init(contentsOf: url as! URL)
            imageDatas["object"] = data as Data?
            RequestWithData()
//            NSData *imageData = UIImagePNGRepresentation([FirstFrameOfTheVideo firstFrameWithVideoURL:self.videoPath size:CGSizeMake(345, 183)]);
            cell.zuopingImageView.image = FirstFrameOfTheVideo.firstFrame(withVideoURL: url as! URL, size: CGSize(width: 345, height: 183))
            cell.zuopingjiahaoImageView.isHidden = true
        }else if mediaType as! String == "public.image" {
            if self.imgtype == "1" {
                // 作品图（全景）
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
                let cell = myTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! FirstUploadContentTableViewCell
                cell.zuopingImageView.image = image
                cell.zuopingjiahaoImageView.isHidden = true
        //        cell.jiantouImageView.isHidden = true
            }else if self.imgtype == "2" {
                // 封面图
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
                let cell = myTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! FirstUploadContentTableViewCell
                cell.fengmianImageView.image = image
                cell.fengmianjiahaoImageView.isHidden = true
        //        cell.jiantouImageView.isHidden = true
            }
        }

        
    }
 
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
  
    //MARK: - Network request - 网络请求
    /** 上传图片/视频*/
    func RequestWithData()  {

        VideoAndImageRequestDatas().RequestWithData(parameters: nil, imageData: imageDatas, success: { (result) in
            if self.flag == "1" {
                //全景
                self.url = result as! String

            }else if self.flag == "2" {
                //视频
                self.url = result as! String

            }else if self.flag == "3" {
                //封面
                self.imgUrl = result as! String

            }

//            self.edituser(keyTemp: "avatar", valueTemp: self.imgUrl!)
        }) { (error) in
            
        }
    }
    
    /**添加VR资源接口*/
    func useraddVr(para:[String:String]) {
        var paras = [String:String]()
        paras = para
        //flag 1：VR全景图 2:VR全景视屏
        paras["flag"] = self.flag
        paras["imgUrl"] = self.imgUrl
        paras["url"] = self.url
        paras["categoryId"] = self.categoryId
        paras["isPublic"] = self.isPublic

       PersonalRequestData().RequestWithuseraddVr(parameters: para) { result in
        let hw = HWTransientAlertViewController()
        hw.titileTemp = "上传成功"
        self.presentPanModal(hw)
        self.navigationController?.popViewController(animated: true)
       } failure: { error in
        let hw = HWTransientAlertViewController()
        hw.titileTemp = "未知错误"
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
